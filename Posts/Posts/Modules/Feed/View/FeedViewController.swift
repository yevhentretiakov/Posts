//
//  ViewController.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 02.09.2022.
//

import UIKit

final class FeedViewController: UIViewController {
    // MARK: - Properties
    var presenter: FeedPresenter?
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    // MARK: - Methods
}

// MARK: - Extensions
extension FeedViewController: FeedView {
    
}
