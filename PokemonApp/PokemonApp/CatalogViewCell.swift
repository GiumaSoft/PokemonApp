//
//  CatalogViewCell.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 15/01/2021.
//

import UIKit

class CatalogViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func setup(with item: CatalogItem) -> UICollectionViewCell {
        imageView.image = item.image
        label.text = item.name
        return self
    }
    
}
