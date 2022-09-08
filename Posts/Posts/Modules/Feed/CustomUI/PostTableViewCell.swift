//
//  PostCell.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 02.09.2022.
//

import UIKit

// MARK: - Enums
enum PostCellState: String {
    case collapsed = "Collapse"
    case expanded = "Expand"
}

final class PostTableViewCell: BaseTableViewCell {
    // MARK: - Properties
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var previewText: UILabel!
    @IBOutlet private weak var likesCount: UILabel!
    @IBOutlet private weak var date: UILabel!
    @IBOutlet private weak var toggleButton: UIButton!
    @IBOutlet private weak var toggleButtonHeightAnchor: NSLayoutConstraint!
    
    private let textLinesLimiter = 2

    var toggleButtonAction: EmptyBlock?
    
    // MARK: - Internal Methods
    func configure(with model: PostUIModel) {
        title.text = model.title
        previewText.text = model.previewText
        likesCount.text = String(model.likesCount)
        date.text = Date.getDate(with: TimeInterval(model.timeshamp)).dateString()
        
        setupToggleButton(with: previewText.bounds.width)
        
        if model.isExpanded {
            setState(.collapsed)
        } else {
            setState(.expanded)
        }
    }
    
    // MARK: - Private Methods
    private func setupToggleButton(with width: CGFloat) {
        toggleButton.cornerRadius = 5
        
        let previewText = previewText.text
 
        if let textFullHeight = previewText?.getRect(width: width, lines: 0).height,
           let textLimitedHeight = previewText?.getRect(width: width, lines: textLinesLimiter).height,
           textFullHeight <= textLimitedHeight {
            hideButton()
        } else {
            showButton()
        }
    }
    
    private func hideButton() {
        toggleButtonHeightAnchor.constant = 0
    }
    
    private func showButton() {
        toggleButtonHeightAnchor.constant = 40
    }
    
    private func setState(_ state: PostCellState) {
        switch state {
        case .collapsed:
            previewText.numberOfLines = 0
        case .expanded:
            previewText.numberOfLines = 2
        }
        toggleButton.setTitle(state.rawValue, for: .normal)
    }
    
    @IBAction private func toggleButtonTapped(_ sender: UIButton) {
        toggleButtonAction?()
    }
}
