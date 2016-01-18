//
//  MarvelNetworkAccess.swift
//  Marvel
//
//  Created by Juan Carrera on 1/8/16.
//  Copyright © 2016 Juan Felipe Carrera Moya. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class MarvelNetworkAccess {
    
    
    private let privateKey = "09ca1ca96c61a7cb79fce2adcf2a34958c688260"
    private let apiKey = "fe10787a86ec69915d7144f193064d49"
    var ts: String?
    var hash: String?
    
    var baseURLString = "https://gateway.marvel.com"
    var headers = ["Accept": "*/*"]
    var currentRequest: Request?
    
    
    func request(method: Alamofire.Method, endpoint: String, var params: [String: AnyObject]? = nil) -> Self {
    
        params = addAuthorization(params)
        currentRequest = Alamofire.request(method, "\(baseURLString)/\(endpoint)", parameters: params, encoding: .URL, headers: headers)
        
        return self
    }
    
    func responseArray<T:Mappable>(completion:(values:[T]?, error: NSError?) -> ()){
        
        if let currentRequest = currentRequest {
            currentRequest.responseArray("data.results", completionHandler: { (response:Response<[T], NSError>) in
                
                switch response.result {
                case .Success(let values):
                    completion(values: values, error: nil)
                case .Failure(let error):
                    completion(values: nil, error: error)
                }
                
            })
        }else {
            completion(values: nil, error: NSError(domain: "MNotRequest", code: 404, userInfo: [:]))
        }
    }
    
    func responseObject<T:Mappable>(completion:(value:T, error: NSError?)){
        
    }
    
    private func addAuthorization(var params: [String: AnyObject]?) -> [String: AnyObject]?{
        
        if params == nil {
            params = [:]
        }
        
        let ts = "\(NSDate().timeIntervalSince1970 * 1000)"
        params?["apikey"] = apiKey
        params?["ts"] = ts
        params?["hash"] = "\(ts)\(privateKey)\(apiKey)".md5()
        
        return params
    }
    
}