//
//  NetworkManager.swift
//  SAPTest
//
//  Created by hamza Ahmed on 30.01.22.
//

import Foundation
import Alamofire
import Alamofire_SwiftyJSON
import SwiftyJSON

//enum Result<T> {
//    case success(T)
//    case failure(Error)
//}
protocol NetworkManager {
    func requestData(parameters: [String: Any], httpMethod: HTTPMethod, completionHandler: @escaping ( Swift.Result<JSON, Error> ) -> Void)
}

// MARK: - base network class to call api
final class NetworkManagerImplementation : NetworkManager {
  
    private let urlString = "\(Constant.baseUrl)api_key=\(Constant.apiKey)&format=json&nojsoncallback=1&safe_search=1"
    
    
    func requestData(parameters: [String: Any], httpMethod: HTTPMethod, completionHandler: @escaping ( Swift.Result<JSON, Error> ) -> Void){
        
        let serviceRequest = request(urlString, method: httpMethod, parameters: parameters, encoding: URLEncoding.default, headers: nil)
        
        serviceRequest.responseSwiftyJSON { (response) in
            
            if response.error == nil{
                guard let data = response.value else { return }
                
                guard let statusCode = response.response?.statusCode
                else {
                    completionHandler(.failure(NetworkError.generic))
                    return
                }
                if statusCode == StatusCode.authExpired.rawValue{
                        completionHandler(.failure(NetworkError.generic))
                }
                else if statusCode != StatusCode.success.rawValue{
                    completionHandler(.failure(NetworkError.generic))
                }
                else{
                    completionHandler(.success(data))
                }
                
            }
            else{
                completionHandler(.failure(NetworkError.generic))
            }
            
        }
    }
   
}
enum StatusCode : Int{
    case success = 200
    case authExpired = 401
    case error = 1002
}
                                      
enum NetworkError: Error{
    case apiResponseError
    case generic
}

