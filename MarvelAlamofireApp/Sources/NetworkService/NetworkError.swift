//
//  NetworkError.swift
//  MarvelAlamofireApp
//
//  Created by Elena Noack on 01.08.22.
//

import Foundation
// MARK: - NetworkError

enum NetworkError: Error, LocalizedError {
    case badURL
    case badJSON
    case serverError
    
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "Invalid URL"
        case .badJSON:
            return "Can't load data"
        case .serverError:
            return "Server not responding. Try again later"
        }
    }
    
}
