//
//  UIView+Extensions.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 05.09.2022.
//

import UIKit

extension UIView {
    var cornerRadius: CGFloat {
        set {
            self.layer.cornerRadius = newValue
        }
        get {
            self.layer.cornerRadius
        }
    }
}
