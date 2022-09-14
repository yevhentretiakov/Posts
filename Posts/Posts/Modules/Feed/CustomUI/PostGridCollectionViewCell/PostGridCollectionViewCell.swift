//
//  PostGridCollectionViewCell.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 14.09.2022.
//

import UIKit

final class PostGridCollectionViewCell: BaseCollectionViewCell {
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
        dateLabel.text = Date.getDate(from: TimeInterval(model.timeshamp)).dateString(in: "dd.MM")
        toggleButtonAction = buttonAction
        setupToggleButton(with: UIScreen.main.bounds.width / 2)
        setState(model.isExpanded ? .expanded : .collapsed)
    }
    
    // MARK: - Private Methods
    private func setupToggleButton(with width: CGFloat) {
        toggleButton.cornerRadius = 5
        if let numberOfLines = previewTextLabel.text?.numberOfLines(width: width),
           numberOfLines <= 2 {
            hideButton()
        } else {
            showButton()
        }
    }
    
    private func hideButton() {
        toggleButton.isHidden = true
    }
    
    private func showButton() {
        toggleButton.isHidden = false
    }
    
    private func setState(_ state: PostCellState) {
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
