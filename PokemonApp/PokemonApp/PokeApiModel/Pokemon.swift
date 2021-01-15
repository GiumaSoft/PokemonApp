//
//  Pokemon.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 14/01/2021.
//

import Foundation

extension PDM {
    
    struct Pokemon: Decodable {
        let id: Int
        let name: String
        let sprites: PokemonSprites
        let stats: [PokemonStat]
        let types: [PokemonType]
    }
}
