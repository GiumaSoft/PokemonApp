//
//  PokemonSprites.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 14/01/2021.
//

import Foundation

extension PDM {
    
    struct PokemonSprites: Decodable {
        
        let frontDefault: String?
        let backDefault: String?
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
            case backDefault = "back_default"
        }
    }

}
