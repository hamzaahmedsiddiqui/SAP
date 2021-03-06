//
//  SearchService.swift
//  SAP
//
//  Created by hamza Ahmed on 31.01.22.
//

import Foundation

/**
 IMPORTANT NOTE:
 
 I can also use URLSession here for networking because we have only one Api to call, but I used Alamofire to showcase my skills as well as I used it because of SwiftyJSON which makes it much easier to translate data into JSON.
 */

protocol SearchService {
    func fetchSearchData(searchText:String,pageNo:Int, completionHandler: @escaping (Swift.Result<Search, Error>)->Void)
    
}
// MARK: - service for calling API
/**
 Base API class for request data
 */
final class SearchServiceImplementation : SearchService {
    /*
     parameter:
     "text" is used for search term
     "page" is used to load another page
     */
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
