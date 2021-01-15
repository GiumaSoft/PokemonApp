//
//  URLComponents.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 15/01/2021.
//

import Foundation

extension URLComponents {
    
    func urlSafe() throws -> URL {
        if let url = self.url { return url }
        throw URL.Error.invalidURL(self.description)
    }
    
}
