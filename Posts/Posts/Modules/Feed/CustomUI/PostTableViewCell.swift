//
//  PostCell.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 02.09.2022.
//

import UIKit

// MARK: - Enums
enum PostCellState {
    case collapsed
    case expanded
    
    var title: String {
        switch self {
        case .collapsed:
            return "Collapse"
        case .expanded:
            return "Expand"
        }
    }
}

final class PostTableViewCell: BaseTableViewCell {
    // MARK: - Properties
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var previewTextLabel: UILabel!
    @IBOutlet private weak var likesCountLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var toggleButton: UIButton!
    @IBOutlet private weak var toggleButtonHeightAnchor: NSLayoutConstraint!
    
    private let textLinesLimit = 2
    private var toggleButtonAction: EmptyBlock?
    
    // MARK: - Internal Methods
    func configure(with model: PostUIModel, buttonAction: EmptyBlock? = nil) {
        titleLabel.text = model.title
        previewTextLabel.text = model.previewText
        likesCountLabel.text = model.likesCount.stringValue
        dateLabel.text = Date.getDate(from: TimeInterval(model.timeshamp)).dateString()
        toggleButtonAction = buttonAction
        
        setState(model.isExpanded ? .collapsed : .expanded)
        setupToggleButton(with: previewTextLabel.bounds.width)
    }
    
    // MARK: - Private Methods
    private func setupToggleButton(with width: CGFloat) {
        toggleButton.cornerRadius = 5
        
        let previewText = previewTextLabel.text
        
        if let textFullHeight = previewText?.getRect(width: width, lines: 0).height,
           let textLimitedHeight = previewText?.getRect(width: width, lines: textLinesLimit).height,
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
            previewTextLabel.numberOfLines = 0
        case .expanded:
            previewTextLabel.numberOfLines = 2
        }
        toggleButton.setTitle(state.title, for: .normal)
    }
    
    @IBAction private func toggleButtonTapped(_ sender: UIButton) {
        toggleButtonAction?()
    }
}
