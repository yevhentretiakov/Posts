//
//  BaseTableViewCell.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 05.09.2022.
//

import UIKit

// MARK: - Protocols
protocol CellRegistrable {
    static func registerNib(in tableView: UITableView)
    static func registerClass(in tableView: UITableView)
}

class BaseTableViewCell: UITableViewCell, CellRegistrable {

}

// MARK: - CellRegistrable for TableView
extension CellRegistrable where Self: BaseTableViewCell {
    static func registerNib(in tableView: UITableView) {
        tableView.register(UINib(nibName: String(describing: Self.self), bundle: nil), forCellReuseIdentifier: String(describing: Self.self))
    }
    
    static func registerClass(in tableView: UITableView) {
        tableView.register(Self.self, forCellReuseIdentifier: String(describing: Self.self))
    }
}
