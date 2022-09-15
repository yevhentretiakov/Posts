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
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: gridCompositionalLayout)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var gridCompositionalLayout: UICollectionViewCompositionalLayout = {
        let inset: CGFloat = 10
        // Item
        let size = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
            heightDimension: NSCollectionLayoutDimension.estimated(.zero)
        )
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = NSDirectionalEdgeInsets(top: .zero, leading: inset, bottom: .zero, trailing: inset)
        // Group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 2)
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: .zero, bottom: inset, trailing: .zero)
        section.interGroupSpacing = 10
        return UICollectionViewCompositionalLayout(section: section)
    }()
    
    private lazy var galleryCompositionalLayout: UICollectionViewCompositionalLayout = {
        // Item
        let size = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
            heightDimension: NSCollectionLayoutDimension.estimated(.zero)
        )
        let item = NSCollectionLayoutItem(layoutSize: size)
        // Group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        return UICollectionViewCompositionalLayout(section: section)
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
    
    private lazy var tabsView: HTabView = {
        let tabs = HTabView(tabs: ["List", "Grid", "Gallery"],
                            indicatorActiveColor: UIColor(named: "AppDarkColor") ?? .blue,
                            indicatorInactiveColor: .label)
        return tabs
    }()
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        presenter.viewDidLoad()
    }
    
    // MARK: - Private Methods
    private func setup() {
        setupNavigationBar()
        setupTabsView()
        setupTableView()
        setupGridCollectionView()
    }
    
    private func setupNavigationBar() {
        title = "Feed"
        navigationItem.rightBarButtonItem = sortButton
    }
    
    private func setupTabsView() {
        tabsView.delegate = self
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        PostTableViewCell.registerNib(in: tableView)
    }
    
    private func setupGridCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        PostCollectionViewCell.registerNib(in: collectionView)
    }
    
    private func showPostsInList() {
        tableView.isHidden = false
        collectionView.isHidden = true
    }
    
    private func showPostsInGrid() {
        tableView.isHidden = true
        collectionView.isHidden = false
        collectionView.setCollectionViewLayout(gridCompositionalLayout, animated: false)
    }
    
    private func showPostsInGallery() {
        tableView.isHidden = true
        collectionView.isHidden = false
        collectionView.setCollectionViewLayout(galleryCompositionalLayout, animated: false)
    }
    
    // MARK: - Layout Methods
    private func layout() {
        layoutTabsView()
        layoutTableView()
        layoutGridCollectionView()
    }
    
    private func layoutTabsView() {
        view.addSubview(tabsView)
        tabsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tabsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tabsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tabsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tabsView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func layoutTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: tabsView.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
    }
    
    private func layoutGridCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: tabsView.bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
    }
}

// MARK: - FeedView
extension FeedViewController: FeedView {
    func reloadData() {
        tableView.reloadData()
        collectionView.reloadData()
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
        var cell = PostTableViewCell.cell(in: tableView, at: indexPath)
        let post = presenter.getItem(at: indexPath.row)
        cell.configure(with: post) { [unowned self] in
            self.presenter.toggleButtonTapped(at: indexPath.row)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.postTapped(with: indexPath.row)
    }
}

// MARK: - UICollectionViewDataSource
extension FeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getItemsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = PostCollectionViewCell.cell(in: collectionView, at: indexPath)
        let post = presenter.getItem(at: indexPath.row)
        cell.configure(with: post) { [unowned self] in
            self.presenter.toggleButtonTapped(at: indexPath.row)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension FeedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.postTapped(with: indexPath.row)
    }
}

// MARK: - HTabViewDelegate
extension FeedViewController: HTabViewDelegate {
    func tabTapped(at index: Int) {
        switch index {
        case 1:
            showPostsInGrid()
        case 2:
            showPostsInGallery()
        default:
            showPostsInList()
        }
    }
}
