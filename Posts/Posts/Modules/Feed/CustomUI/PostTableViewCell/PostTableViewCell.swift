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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var previewTextLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var toggleButton: UIButton!
    
    let textLinesLimit = 2
    var toggleButtonAction: EmptyBlock?
    
    @IBAction func toggleButtonTapped(_ sender: UIButton) {
        toggleButtonAction?()
    }
}
