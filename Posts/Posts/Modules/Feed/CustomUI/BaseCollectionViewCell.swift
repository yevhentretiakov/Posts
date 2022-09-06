//
//  BaseCollectionViewCell.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 05.09.2022.
//

import UIKit

// MARK: - Protocols
protocol CollectionCellDequeuable {
    static func cell(in collectionView: UICollectionView, at indexPath: IndexPath) -> Self
}

class BaseCollectionViewCell: UITableViewCell, CellRegistrable, CollectionCellDequeuable {

}

// MARK: - CellRegistrable for CollectionView
extension CellRegistrable where Self: BaseCollectionViewCell {
    static func registerNib(in collectionView: UITableView) {
        collectionView.register(UINib(nibName: String(describing: Self.self), bundle: nil), forCellReuseIdentifier: String(describing: Self.self))
    }
    
    static func registerClass(in collectionView: UITableView) {
        collectionView.register(Self.self, forCellReuseIdentifier: String(describing: Self.self))
    }
}

// MARK: - CollectionCellDequeuable
extension CollectionCellDequeuable {
    static func cell(in collectionView: UICollectionView, at indexPath: IndexPath) -> Self {
        collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: Self.self), for: indexPath) as! Self
    }
}
