//
//  SearchService.swift
//  SAPTest
//
//  Created by hamza Ahmed on 31.01.22.
//

import Foundation


protocol SearchService {
    func fetchSearchData(searchText:String,pageNo:Int, completionHandler: @escaping (Swift.Result<Search, Error>)->Void)
    
}
// MARK: - service for calling api
final class SearchServiceImplementation : SearchService {
    
    let networkManager = NetworkManagerImplementation()
    func fetchSearchData(searchText: String, pageNo: Int, completionHandler: @escaping (Swift.Result<Search, Error>) -> Void) {
        
        let params = [
            "text": searchText,
            "page":pageNo
        ] as [String : Any]
        
        networkManager.requestData(parameters: params, httpMethod: .get) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do{
                    let model = try decoder.decode(Search.self, from: data.rawData())
                    completionHandler(.success(model))
                }
                catch{
                    completionHandler(.failure(NetworkError.apiResponseError))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
