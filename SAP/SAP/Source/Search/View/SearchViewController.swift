//
//  SearchViewController.swift
//  SAP
//
//  Created by hamza Ahmed on 30.01.22.
//

import UIKit
/**
 Note: SearchViewController is now very basic. It could have been way much better in terms of design if given time.
 
 */
class SearchViewController: UIViewController {
    enum CollectionViewSection {
        case main
    }
    typealias Snapshot = NSDiffableDataSourceSnapshot<CollectionViewSection, Photo>
    typealias DataSource = UICollectionViewDiffableDataSource<CollectionViewSection, Photo>
    
    private lazy var dataSource = makeDataSource()
    private let reuseIdentifier = Constant.identifierForPhotoCollectionCell
    private let searchBarPlaceholder = "Search Images ..."
    private var isWaitingForResult = false
    lazy var searchBar: UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 20))
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            let nib = UINib(nibName: reuseIdentifier, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        }
    }
    
    private lazy var historyViewController: HistoryTableViewController = {
        historyViewControllerSetup()
    }()
    
    lazy private var viewModel : SearchViewModel = {
        let service = SearchServiceImplementation()
        let viewModel = SearchViewModelImplementation(service: service)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - SearchViewController functions.
extension SearchViewController{
   
    private func setupView(){
        searchBar.placeholder = searchBarPlaceholder
        searchBar.delegate = self
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        setLayoutForCollection()
        applySnapshot(animatingDifferences: false)
    }
    private func setLayoutForCollection(){
        let itemSize = view.frame.width / 3
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
    }
    private func historyViewControllerSetup() -> HistoryTableViewController{
        let storyboard = UIStoryboard(name: Constant.storyboardIdentifier, bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: Constant.identifierForHistoryTable) as! HistoryTableViewController
        viewController.didSelectSearchText = { [weak self] history in
            if let self = self {
                self.searchBar.text = history.searchText
                self.getSearchData(searchText: history.searchText, pageNo: 1)
                self.hideHistory()
            }
        }
        self.add(asChildViewController: viewController)
        return viewController
    }
    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, photo) ->
                UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: self.reuseIdentifier,
                    for: indexPath) as? PhotoCollectionViewCell
                let cellViewModel = self.viewModel.cellViewModelForRow(row: indexPath.row)
                cell?.cellViewModel = cellViewModel
                return cell
            })
        return dataSource
    }
    private func applySnapshot(animatingDifferences: Bool = true){
        if viewModel.getPhotosArray().count == 0{
            self.showAlert("No picture found", "")
        }
        var snapShot = Snapshot()
        snapShot.appendSections([.main])
        snapShot.appendItems(viewModel.getPhotosArray())
        dataSource.apply(snapShot, animatingDifferences: animatingDifferences)
    }

    private func getSearchData(searchText: String, pageNo: Int){
        viewModel.didUpdateSearchResult(searchText: searchText, pageNo: pageNo) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.applySnapshot()
                self.isWaitingForResult = false
                
                break
                
            case .failure(let error):
                //show alert
                self.showAlert("Error", "There is some issue to get search result")
                print(error.localizedDescription)
            }
        }
    }
    /**
     Displays alert
     
     - parameter title: String
     - parameter message: String
     */
    private func showAlert(_ title: String, _ message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController.Style.alert.controller(
                title: title,
                message: message,
                actions: [
                    Constant.dismissButtonTitle.alertAction()
                ])
            self.present(alert, animated: true)
        }
    }
    /*
     we created these function to add or remove another view controller  into this view controller
     */
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    private func showHistory(){
        add(asChildViewController: historyViewController)
    }
    private func hideHistory(){
        remove(asChildViewController: historyViewController)
    }
}

// MARK: - UISearchBarDelegate.
extension SearchViewController:UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        showHistory()
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        hideHistory()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        hideHistory()
        guard let searchText = searchBar.text, searchText != "" else {
            return
        }
        viewModel.storeSearchHistory(searchText: searchText)
        getSearchData(searchText: searchText, pageNo: 1)
    }
}

//MARK: - collectionViewDelegate,UICollectionViewDelegateFlowLayout
extension SearchViewController:UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    /**
     The collection View cell height and width is set according to show three items per row
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let  size = collectionView.frame.size.width / CGFloat(3) - CGFloat((3 - 1)) * 5
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.getPhotosArray().count / 2 && !isWaitingForResult {
            getSearchData(searchText: viewModel.getLastSearchText(), pageNo: viewModel.getPageNo() + 1)
        }
    }
    
}
