//
//  UIView.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 30/11/21.
//

import UIKit

extension UIView {
    
    func addSubviewToCenter(view: UIView) {
        let view = view
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func addSubviewToFit(view: UIView) {
        let view = view
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
    
}
