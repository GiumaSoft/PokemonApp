//
//  ProfileStatsViewCell.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 15/01/2021.
//

import UIKit

class ProfileStatsViewCell: UITableViewCell {
    
    @IBOutlet weak var attribute: UILabel!
    @IBOutlet weak var value: UILabel!

    func setup(_ item: PDM.PokemonStat) -> Self {
        attribute.text = item.stat.name.capitalized
        value.text = String( item.baseStat )
        return self
    }
    
}
