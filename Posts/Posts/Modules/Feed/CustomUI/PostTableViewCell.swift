//
//  PostCell.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 02.09.2022.
//

import UIKit

final class PostTableViewCell: BaseTableViewCell {
    // MARK: - Properties
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var previewText: UILabel!
    @IBOutlet private weak var likesCount: UILabel!
    @IBOutlet private weak var date: UILabel!
    @IBOutlet weak var toggleButton: UIButton!
    
    @IBOutlet private weak var toggleButtonBottomAnchor: NSLayoutConstraint!
    @IBOutlet private weak var toggleButtonHeightAnchor: NSLayoutConstraint!
    @IBOutlet weak var toogleButtonTopAnchor: NSLayoutConstraint!
    
    private let textLinesLimiter = 2
    private let contentInset: CGFloat = 20
    
    // MARK: - Internal Methods
    func configure(with model: PostModel, width: CGFloat) {
        title.text = model.title
        previewText.text = model.previewText
        likesCount.text = String(model.likesCount)
        date.text = model.timeshamp.date.extract("dd MMMM")
        setupToggleButton(with: width)
        
        if let isExpanded = model.isExpanded, isExpanded {
            previewText.numberOfLines = 0
            toggleButton.setTitle("Collapse", for: .normal)
        } else {
            previewText.numberOfLines = 2
            toggleButton.setTitle("Expand", for: .normal)
        }
    }
    
    // MARK: - Private Methods
    private func setupToggleButton(with width: CGFloat) {
        toggleButton.cornerRadius = 5
        
        let previewText = previewText.text
        let labelWidth = width - contentInset
        
        if let textFullHeight = previewText?.getFrameRect(width: labelWidth, lines: 0).height,
           let textLimitedHeight = previewText?.getFrameRect(width: labelWidth, lines: textLinesLimiter).height,
           textFullHeight <= textLimitedHeight {
            hideButton()
        } else {
            showButton()
        }
    }
    
    private func hideButton() {
        toggleButtonBottomAnchor.constant = 0
        toggleButtonHeightAnchor.constant = 0
        toogleButtonTopAnchor.constant = 0
    }
    
    private func showButton() {
        toggleButtonBottomAnchor.constant = 10
        toggleButtonHeightAnchor.constant = 40
        toogleButtonTopAnchor.constant = 10
    }
}
