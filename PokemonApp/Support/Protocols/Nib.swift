//
//  Nib.swift
//  AZCalendar
//
//  Created by Giuseppe Mazzilli on 28/12/2020.
//

import UIKit

protocol Nib {
    
    func loadNib(with nibName: String)

}

extension Nib {
    
    private func loadNib(nibName: String, bundle: Bundle) -> UIView {
        #if !TARGET_INTERFACE_BUILDER
        guard let _ = bundle.path(forResource: nibName, ofType: "nib") else {
            fatalError("can't find \(nibName) xib resource in current bundle") }
        #endif
        
        guard let nibView = bundle.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView
            else {
            fatalError("can't find \(nibName) xib resource in current bundle")
        }
        
        return nibView
    }
    
}

extension Nib where Self: UIView {
    
    func loadNib(with nibName: String = "\(Self.self)") {
        let nibView = loadNib(nibName: nibName, bundle: Bundle(for: Self.self))
        nibView.frame = bounds
        addSubview(nibView)
    }
    
}

extension Nib where Self: UIViewController {
    
    func loadNib(with nibName: String = "\(Self.self)") {
        let nibView = loadNib(nibName: nibName, bundle: Bundle(for: Self.self))
        view = nibView
    }
    
}
