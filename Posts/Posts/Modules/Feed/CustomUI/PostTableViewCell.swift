//
//  PostCell.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 02.09.2022.
//

import UIKit

class PostTableViewCell: BaseTableViewCell {
    // MARK: - Properties
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var previewText: UILabel!
    @IBOutlet private weak var likesCount: UILabel!
    @IBOutlet private weak var date: UILabel!
    @IBOutlet private weak var toggleButton: UIButton!
    @IBOutlet private weak var toggleButtonBottomAnchor: NSLayoutConstraint!
    @IBOutlet private weak var toggleButtonHeightAnchor: NSLayoutConstraint!
    
    // MARK: - Life Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        setupToggleButton()
    }
    
    // MARK: - Methods
    func configure(with model: PostModel) {
        title.text = model.title
        previewText.text = model.previewText
        likesCount.text = String(model.likesCount)
        date.text = model.timeshamp.date.extract("dd MMMM")
        
        if previewText.bounds.height <= (previewText.text?.getFrameRect(width: previewText.bounds.width, lines: 2).height)! {
            hideButton()
            print("Hide")
        }
    }
    
    private func setupToggleButton() {
        toggleButton.cornerRadius = 5
    }
    
    @IBAction func toggleButtonTapped(_ sender: UIButton) {
        
    }
    
    private func hideButton() {
        toggleButtonBottomAnchor.constant = 0
        toggleButtonHeightAnchor.constant = 0
    }
    
    private func showButton() {
        toggleButtonBottomAnchor.constant = 10
        toggleButtonHeightAnchor.constant = 40
    }
}
