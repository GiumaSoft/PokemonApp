//
//  Alerts.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 01/12/21.
//

import UIKit

enum Alerts {
    
    case connectionError
    
    private var alert: UIAlertController {
        switch self {
        case .connectionError:
            let alert = UIAlertController(title: "Connection error", message: "An error occurred while attempting to fetch data from server, please close application and try again later.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
            return alert
        }
    }
    
    func show() {
        if var current = UIApplication.shared.keyWindow?.rootViewController {
            while let presented = current.presentedViewController {
                current = presented
            }
            let segue = current.navigationController ?? current
            segue.present(alert, animated: true, completion: nil)
        }
    }
    
}
