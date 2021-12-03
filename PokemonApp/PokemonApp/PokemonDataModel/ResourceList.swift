//
//  ResourceList.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 14/01/2021.
//

import Foundation

extension PDM {
    
    struct ResourceList: Decodable {
        let count: Int                          // The total number of resources available from this API.
        let next: String?                       // The URL for the next page in the list.
        let previous: String?                   // The URL for the previous page in the list.
        let results: [NamedAPIResource]         // A list of named API resources.
    }
}

