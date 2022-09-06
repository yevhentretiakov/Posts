//
//  UIViewController+Extensions.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 06.09.2022.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, actions: [UIAlertAction]? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let actions = actions {
            actions.forEach { action in
                alert.addAction(action)
            }
        } else {
            alert.addAction(UIAlertAction(title: "OK", style: .default))
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    var isModal: Bool {
        return presentingViewController != nil
    }
}
