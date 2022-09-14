//
//  UIView+Extensions.swift
//  HTabView
//
//  Created by Yevhen Tretiakov on 19.08.2022.
//

import UIKit

extension UIView {
    func center(relativeTo view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
