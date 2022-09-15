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
            return "Expand"
        case .expanded:
            return "Collapse"
        }
    }
}

final class PostTableViewCell: BaseTableViewCell, PostCell {
    // MARK: - Properties
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var previewTextLabel: UILabel!
    @IBOutlet private weak var likesCountLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var toggleButton: UIButton!
    
    private let textLinesLimit = 2
    private var toggleButtonAction: EmptyBlock?
    
    // MARK: - Internal Methods
    func configure(with model: PostUIModel, buttonAction: EmptyBlock? = nil) {
        titleLabel.text = model.title
        previewTextLabel.text = model.previewText
        likesCountLabel.text = model.likesCount.stringValue
        dateLabel.text = Date.getDate(from: TimeInterval(model.timeshamp)).dateString()
        toggleButtonAction = buttonAction
        setupToggleButton(with: UIScreen.main.bounds.width)
        setState(model.isExpanded ? .expanded : .collapsed)
    }
    
    // MARK: - Private Methods
    func setupToggleButton(with width: CGFloat) {
        toggleButton.cornerRadius = 5
        if let numberOfLines = previewTextLabel.text?.numberOfLines(width: width),
           numberOfLines <= 2 {
            hideButton()
        } else {
            showButton()
        }
    }
    
    func hideButton() {
        toggleButton.isHidden = true
    }
    
    func showButton() {
        toggleButton.isHidden = false
    }
    
    func setState(_ state: PostCellState) {
        switch state {
        case .collapsed:
            previewTextLabel.numberOfLines = 2
        case .expanded:
            previewTextLabel.numberOfLines = 0
        }
        toggleButton.setTitle(state.title, for: .normal)
    }
    
    @IBAction private func toggleButtonTapped(_ sender: UIButton) {
        toggleButtonAction?()
    }
}
