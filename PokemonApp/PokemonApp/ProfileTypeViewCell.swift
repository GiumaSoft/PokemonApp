//
//  ProfileTypeViewCell.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 15/01/2021.
//

import UIKit

class ProfileTypeViewCell: UITableViewCell {
    
    @IBOutlet weak var elementType: UILabel!
    
    func setup(_ element: PDM.PokemonType) -> Self {
        elementType.text = element.type.name
        return self
    }
    
}
