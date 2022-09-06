//
//  Int+Extensions.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 05.09.2022.
//

import Foundation

extension Int {
    var date: Date {
        return NSDate(timeIntervalSince1970: TimeInterval(self)) as Date
    }
}
