//
//  Date+Format.swift
//  Journal
//
//  Created by Hai Le on 3/5/19.
//  Copyright © 2019 Hai Le. All rights reserved.
//

import Foundation

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy hh:mm"
        return formatter.string(from: self)
    }
    
    func toDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: self)
    }
}
