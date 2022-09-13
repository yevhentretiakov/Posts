//
//  DetailViewController.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 07.09.2022.
//

import UIKit

final class DetailViewController: UIViewController {
    // MARK: - Properties
    var presenter: DetailPresenter!
    var postId: Int!
    
    // MARK: - Outlets
    @IBOutlet private weak var postImageView: UIImageView!
    @IBOutlet private weak var postTitleLabel: UILabel!
    @IBOutlet private weak var postBodyLabel: UILabel!
    @IBOutlet private weak var postLikesCountLabel: UILabel!
    @IBOutlet private weak var postDateLabel: UILabel!
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(withPostId: postId)
    }
}

// MARK: - DetailView
extension DetailViewController: DetailView {
    func showMessage(title: String, message: String) {
        showAlert(title: title, message: message)
    }
    
    func configurePost(with model: PostDetailModel) {
        postImageView.setImage(with: model.imageUrl)
        postTitleLabel.text = model.title
        postBodyLabel.text = model.body
        postLikesCountLabel.text = model.likesCount.stringValue
        postDateLabel.text = Date.getDate(from: TimeInterval(model.timeshamp)).dateString()
    }
}
