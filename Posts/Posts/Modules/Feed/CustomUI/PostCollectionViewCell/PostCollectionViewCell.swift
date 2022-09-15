//
//  PostCollectionViewCell.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 14.09.2022.
//

import UIKit

// MARK: - Protocols
protocol PostCell: AnyObject {
    var titleLabel: UILabel! { get set }
    var previewTextLabel: UILabel! { get set }
    var likesCountLabel: UILabel! { get set }
    var dateLabel: UILabel! { get set }
    var toggleButton: UIButton! { get set }
    var textLinesLimit: Int { get }
    var toggleButtonAction: EmptyBlock? { get set }
    func configure(with model: PostUIModel, buttonAction: EmptyBlock?)
    func setupToggleButton(with width: CGFloat)
    func hideButton()
    func showButton()
    func setState(_ state: PostCellState)
    func toggleButtonTapped(_ sender: UIButton)
}

extension PostCell {
    // MARK: - Internal Methods
    func configure(with model: PostUIModel, buttonAction: EmptyBlock? = nil) {
        titleLabel.text = model.title
        previewTextLabel.text = model.previewText
        likesCountLabel.text = model.likesCount.stringValue
        dateLabel.text = Date.getDate(from: TimeInterval(model.timeshamp)).dateString(in: "dd.MM")
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
}

final class PostCollectionViewCell: BaseCollectionViewCell, PostCell {
    // MARK: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var previewTextLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var toggleButton: UIButton!
    
    var toggleButtonAction: EmptyBlock?
    let textLinesLimit = 2
    
    @IBAction func toggleButtonTapped(_ sender: UIButton) {
        toggleButtonAction?()
    }
}
