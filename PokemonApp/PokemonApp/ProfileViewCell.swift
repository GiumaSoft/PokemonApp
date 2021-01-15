//
//  ProfileViewCell.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 15/01/2021.
//

import UIKit

class ProfileViewCell: UITableViewCell {

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func setup(_ item: CatalogItem) -> Self {
        picture.image = item.image
        nameLabel.text = item.name.capitalized
        return self
    }
    
}
