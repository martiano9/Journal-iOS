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
    
    func toDateString(withFormat format:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}
