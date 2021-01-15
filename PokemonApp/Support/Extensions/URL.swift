//
//  URL.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 15/01/2021.
//

import Foundation

extension URL {
    
    enum Error : Swift.Error, LocalizedError {
        
        case invalidURL(String)
        
        var errorDescription: String? {
            switch self {
            case .invalidURL(let url):
                return "Failed to create url with '\(url)'."
            }
        }
        
        var failureReason: String? {
            switch self {
            case .invalidURL(_):
                return "Possible reason are url may contains unadmitted character or has invalid format."
            }
        }
        
        var recoverySuggestion: String? {
            switch self {
            case .invalidURL(_):
                return "Refer to https://tools.ietf.org/html/rfc3986 document for valid url format."
            }
        }

    }
    
    init(safe: String) throws {
        guard let url = URL(string: safe) else {
            throw URL.Error.invalidURL(safe)
        }
        self = url
    }
    
}
