//
//  UICollectionView.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 14/01/2021.
//

import UIKit

extension UICollectionView {
    /**
     * Register a nib object containing a cell with the table view using class name identifier
     */
    func register<T>(cellNibClass: T.Type) where T : UICollectionViewCell {
        register(UINib(nibName: "\(T.self)", bundle: Bundle.main), forCellWithReuseIdentifier: "\(T.self)")
    }
    /**
     * Dequeue a reusable collectionview cell using class name identifier
     */
    func dequeueReusableCell<T>(fromClass: T.Type, for indexPath: IndexPath) -> T? where T : UICollectionViewCell {
        dequeueReusableCell(withReuseIdentifier: "\(T.self)", for: indexPath) as? T
    }    
}
