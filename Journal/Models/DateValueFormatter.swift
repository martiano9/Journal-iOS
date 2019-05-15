//
//  DateValueFormatter.swift
//  Journal
//
//  Created by Hai Le on 15/5/19.
//  Copyright © 2019 Hai Le. All rights reserved.
//

import Foundation
import Charts

public class DateValueFormatter: NSObject, IAxisValueFormatter {
    private let dateFormatter = DateFormatter()
    
    override init() {
        super.init()
        dateFormatter.dateFormat = "dd MMM"
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}

public class MoodValueFormatter: NSObject, IAxisValueFormatter {
    private let dateFormatter = DateFormatter()
    
    override init() {
        super.init()
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if (value == 0) {
            return ""
        }
        return Mood.list[Int(value)-1].description
    }
}
