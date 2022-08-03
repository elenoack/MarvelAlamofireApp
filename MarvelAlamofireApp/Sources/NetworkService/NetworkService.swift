//
//  NetworkService.swift
//  MarvelAlamofireApp
//
//  Created by Elena Noack on 01.08.22.
//

import Foundation
import Alamofire

// MARK: - EndPoint

enum EndPoint: String {
    case characters = "characters"
    case comics = "comics"
}

// MARK: - Configuration

fileprivate struct Configuration {
    
    static let baseURL = "https://gateway.marvel.com"
    static let path = "/v1/public/"
    static let apiPublicKey = "7fa387c55663580311962068f57fdf2c"
    static let apiPrivateKey = "270952913c36cdaa7c39f43fb37b96c5d8ae5543"
    static var timestamp: String {
        return String(Date().getCurrentTimestamp())
    }
    static var hash: String {
        return String(timestamp + apiPrivateKey + apiPublicKey).md5()
    }
}

// MARK: - NetworkService

public class NetworkService {
    
    var url: String { "\(Configuration.baseURL)\(Configuration.path)\(EndPoint.characters)" }
    
    static var limitCount: Int = 0 
    
    var parameters = ["apikey": Configuration.apiPublicKey,
                      "ts": Configuration.timestamp,
                      "hash": Configuration.hash,
//                      "limit" : "\(20)",
                      "offset" : "\(NetworkService.limitCount)"]
    
    func fetchData(with name: String? = nil, completion: @escaping (Result<[Character], NetworkError>) -> Void) {
        
        if let name = name {
            if !name.isEmpty {
                parameters["nameStartsWith"] = name
            } else {
                parameters.removeValue(forKey: "nameStartsWith")
            }
        }
        
        AF.sessionConfiguration.timeoutIntervalForRequest = 90
        AF.request(url, method: .get,
                   parameters: parameters,
                   encoding: URLEncoding.default)
            .validate(statusCode: 200..<299)
            .validate(contentType: ["application/json"])
            .responseData { (responseData) in
               guard let responce = responseData.response
                else {
                   return completion(.failure(.serverError)) }
                
                if responce.statusCode >= 300 {
                    completion(.failure(.badURL))
                }
            }
            .responseDecodable(of: DataModel.self) { (response) in
                guard let characters = response.value?.data
                else {
                    return completion(.failure(.badJSON)) }
                
                completion(.success(characters.list))
            }
    }
    
    func fetchComicsData(with id: String, completion: @escaping (Result<[Character], NetworkError>) -> Void) {
        
        var url: String { "\(Configuration.baseURL)\(Configuration.path)\(EndPoint.characters)/\(id)/\(EndPoint.comics)" }
        
        AF.request(url, method: .get,
                   parameters: ["apikey": Configuration.apiPublicKey,
                                "ts": Configuration.timestamp,
                                "hash": Configuration.hash],
                   encoding: URLEncoding.default)
            .validate(statusCode: 200..<299)
            .validate(contentType: ["application/json"])
            .responseData { (responseData) in
               guard let responce = responseData.response
                else {
                   return completion(.failure(.serverError)) }
            
                if responce.statusCode >= 300 {
                    completion(.failure(.badURL))
                }
            }
            .responseDecodable(of: DataModel.self) { (response) in
                guard let characters = response.value?.data
                else {
                    return completion(.failure(.badJSON)) }
                
                completion(.success(characters.list))
            }
//            .responseJSON(completionHandler: { (response) in
//                     print(response.request) // This returns just the url eg "http://api.com
//                     print(response.request?.httpBody) // This returns `Optional(85 bytes)`
//                 })
     
    }
    
}
