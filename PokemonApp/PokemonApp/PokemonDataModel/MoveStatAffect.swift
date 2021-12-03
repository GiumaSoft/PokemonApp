//
//  MoveStatAffect.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 15/01/2021.
//

import Foundation

extension PDM {
    
    struct MoveStatAffect: Decodable {
        let change: Int
        let move: NamedAPIResource
    }
}

