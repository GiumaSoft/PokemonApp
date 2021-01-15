//
//  NamedAPIResource.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 14/01/2021.
//

import Foundation

extension PDM {
    
    struct NamedAPIResource: Decodable {
        let name: String            // The name of the referenced resource.
        let url: String             // The URL of the referenced resource.
    }
}

