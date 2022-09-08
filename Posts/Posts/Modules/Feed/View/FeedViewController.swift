//
//  ViewController.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 02.09.2022.
//

import UIKit

final class FeedViewController: UIViewController {
    // MARK: - Properties
    var presenter: FeedPresenter!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private lazy var menuActions: [UIAction] = {
        return [
            UIAction(title: "Sort by Date", image: UIImage(systemName: "clock.arrow.circlepath")) { _ in
                self.presenter.sortPosts(by: .date)
            },
            UIAction(title: "Sort by Likes", image: UIImage(systemName: "heart")) { _ in
                self.presenter.sortPosts(by: .likesCount)
            }
        ]
    }()
    
    private lazy var sortMenu: UIMenu = {
        return UIMenu(title: "Sort Options", image: nil, identifier: nil, options: [], children: menuActions)
    }()
    
    private lazy var sortButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .plain, target: self, action: nil)
        button.tintColor = UIColor(named: "AppDarkColor")
        button.menu = sortMenu
        return button
    }()
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        layoutTableView()
        presenter.viewDidLoad()
    }
    
    // MARK: - Private Methods
    private func setupNavigationBar() {
        title = "Feed"
        navigationItem.rightBarButtonItem = sortButton
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        PostTableViewCell.registerNib(in: tableView)
    }
    
    // MARK: - Layout Methods
    private func layoutTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
    }
}

// MARK: - FeedView
extension FeedViewController: FeedView {
    func reloadData() {
        tableView.reloadData()
    }
    func showMessage(title: String, message: String) {
        showAlert(title: title, message: message)
    }
}

// MARK: - UITableViewDataSource
extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getItemsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PostTableViewCell.cell(in: tableView, at: indexPath)
        let post = presenter.getItem(at: indexPath.row)
        cell.configure(with: post)
        cell.toggleButtonAction = { [unowned self] in
            self.presenter.toggleButtonTapped(at: indexPath.row)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
