//
//  TableViewController.swift
//  SAPTest
//
//  Created by hamza Ahmed on 31.01.22.
//

import UIKit

class HistoryTableViewController: UIViewController {
    private let reuseIdentifier = Constant.identifierForHistoryTableCell
    var didSelectSearchText: ((_ text: History) -> Void)?
    @IBOutlet weak var historyTable: UITableView!{
        didSet{
            let nib = UINib(nibName: reuseIdentifier, bundle: nil)
            historyTable.register(nib, forCellReuseIdentifier: reuseIdentifier)
        }
    }
    let viewModel : HistoryViewModel = HistoryViewModelImplementation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        historyTable.reloadData()
    }
}

extension HistoryTableViewController{
    func setUpView(){
        historyTable.delegate = self
        historyTable.dataSource = self
    }
}
 
// MARK: - tableviewDelegate, tableViewDatasource.

extension HistoryTableViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getHistoryArray().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTable.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! HistoryTableViewCell
        cell.cellViewModel = viewModel.cellViewModelForRow(row: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! HistoryTableViewCell
        didSelectSearchText?(cell.cellViewModel.didSelectHistory())
    }
    
}

    
    
    

