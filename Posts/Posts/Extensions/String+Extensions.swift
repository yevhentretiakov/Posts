//
//  String+Extensions.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 05.09.2022.
//

import UIKit

extension String {
    func numberOfLines(font: UIFont = UIFont.systemFont(ofSize: 17) , width: CGFloat) -> Int {
        let rect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let attributedString = NSAttributedString(string: self, attributes: [NSAttributedString.Key.font : font])
        let boundingBox = attributedString.boundingRect(with: rect, options: .usesLineFragmentOrigin, context: nil)
        let numberOfLines = Int(boundingBox.height/font.lineHeight)
        return numberOfLines
    }
    func textWidth(_ font: UIFont = .systemFont(ofSize: 17)) -> CGFloat {
        return self.size(withAttributes: [NSAttributedString.Key.font : font]).width
    }
}
