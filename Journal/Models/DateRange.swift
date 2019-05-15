//
//  Weather.swift
//  Journal
//
//  Created by Hai Le on 5/5/19.
//  Copyright © 2019 Hai Le. All rights reserved.
//

import Foundation
import UIKit

struct DateRange {
    var string: String
    var value: Int
    
    static var list: [DateRange] = [
        DateRange(string: "Last 7 days", value: 7),
        DateRange(string: "Last 30 days", value: 30),
        DateRange(string: "Last 60 days", value: 60),
    ]
}
