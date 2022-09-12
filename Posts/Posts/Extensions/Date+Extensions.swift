//
//  Date+Extensions.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 05.09.2022.
//

import Foundation

extension Date {
    private static var dateFormatter = DateFormatter()
    
    static func getDate(from timeInterval: Double) -> Date {
        return Date(timeIntervalSince1970: timeInterval)
    }
    
    func dateString(in format: String = "dd MMMM") -> String {
        let formatter = Date.dateFormatter
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
