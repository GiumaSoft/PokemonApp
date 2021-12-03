//
//  UITableView.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 30/11/21.
//

import UIKit

extension UITableView {
    
    /*
        @available(iOS 6.0, *)
        open func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell // newer dequeue method guarantees a cell is returned and resized properly, assuming identifier is registered
        
        @available(iOS 6.0, *)
        open func register(_ cellClass: AnyClass?, forCellReuseIdentifier identifier: String)
     */
    
    func dequeueReusableCell<T>(_ cellClass: T.Type?) -> T where T: UITableViewCell {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.name) as? T else {
            fatalError("Failed to dequeue table view cell with identifier: \"\(T.name)\"")
        }
        return cell
    }

}
