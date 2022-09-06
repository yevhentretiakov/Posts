//
//  Date+Extensions.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 05.09.2022.
//

import Foundation

extension Date {
    func extract(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
