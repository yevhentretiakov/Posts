//
//  BaseCollectionViewCell.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 05.09.2022.
//

import UIKit

// MARK: - Protocols
protocol CollectionCellRegistrable {
    static func registerNib(in collectionView: UICollectionView)
    static func registerClass(in collectionView: UICollectionView)
}

protocol CollectionCellDequeuable {
    static func cell(in collectionView: UICollectionView, at indexPath: IndexPath) -> Self
}

class BaseCollectionViewCell: UICollectionViewCell, CollectionCellRegistrable, CollectionCellDequeuable {

}

// MARK: - CellRegistrable for CollectionView
extension CollectionCellRegistrable where Self: BaseCollectionViewCell {
    static func registerNib(in collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: String(describing: Self.self), bundle: nil), forCellWithReuseIdentifier: String(describing: Self.self))
    }
    
    static func registerClass(in collectionView: UICollectionView) {
        collectionView.register(Self.self, forCellWithReuseIdentifier: String(describing: Self.self))
    }
}

// MARK: - CollectionCellDequeuable
extension CollectionCellDequeuable {
    static func cell(in collectionView: UICollectionView, at indexPath: IndexPath) -> Self {
        collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: Self.self), for: indexPath) as! Self
    }
}
