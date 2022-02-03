//
//  SearchViewModel.swift
//  SAP
//
//  Created by hamza Ahmed on 30.01.22.
//

import Foundation
// MARK: - searchViewModel
protocol SearchViewModel {
    func didUpdateSearchResult(searchText : String, pageNo: Int, completionHandler : @escaping (Swift.Result<Bool,Error>) -> Void)
    func storeSearchHistory(searchText: String)
    func cellViewModelForRow(row: Int)-> PhotoCellViewModel
    func getPhotosArray() -> [Photo]
    func getPageNo()-> Int
    func getLastSearchText()-> String
}
// MARK: - SearchViewModelImplementation
class SearchViewModelImplementation: SearchViewModel  {
    let service: SearchService
    private var photosArr: [Photo] = []
    private var pageNo: Int = 0
    private var lastSearchText: String = ""
    init(service : SearchService) {
        self.service = service
    }
    func didUpdateSearchResult(searchText: String, pageNo: Int, completionHandler: @escaping (Swift.Result<Bool, Error>) -> Void) {
        self.pageNo = pageNo
        self.lastSearchText = searchText
        service.fetchSearchData(searchText: searchText, pageNo: pageNo) { [unowned self] result in
            switch result {
            case .success(let data):
                let photo = data.photos.photo
                if pageNo != 1 {
                    self.photosArr.append(contentsOf: photo)
                }
                else{
                    self.photosArr = photo
                }
                completionHandler(.success(true))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    func storeSearchHistory(searchText: String){
        let userDefault = UserDefaults.standard
        var historyArray: [History] = userDefault.loadHistory()
        let history = History(searchText: searchText)
        historyArray.append(history)
        userDefault.saveHistory(historyArray)
    }
    func cellViewModelForRow(row: Int)-> PhotoCellViewModel {
        let photo = photosArr[row]
        return PhotoCellViewModel(photo: photo)
    }
    
    func getPhotosArray() -> [Photo] {
        return photosArr
    }
    func getPageNo()-> Int{
        return pageNo
    }
    func getLastSearchText()-> String{
        return lastSearchText
    }
   
}
