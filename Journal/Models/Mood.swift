//
//  Mood.swift
//  Journal
//
//  Created by Hai Le on 3/5/19.
//  Copyright © 2019 Hai Le. All rights reserved.
//

import Foundation
import UIKit

struct Mood {
    var image: UIImage
    var color: UIColor
    var value: Int32
    var description: String
    
    static var list: [Mood] = [
        Mood(image: #imageLiteral(resourceName: "mood_1"), color: #colorLiteral(red: 0.2401247919, green: 0.3073660135, blue: 0.6986169219, alpha: 1), value: 1, description: "Angry"),
        Mood(image: #imageLiteral(resourceName: "mood_2"), color: #colorLiteral(red: 0.130487442, green: 0.5794468522, blue: 0.9492992759, alpha: 1), value: 2, description: "Sad"),
        Mood(image: #imageLiteral(resourceName: "mood_3"), color: #colorLiteral(red: 0, green: 0.5820171833, blue: 0.538072288, alpha: 1), value: 3, description: "Calm"),
        Mood(image: #imageLiteral(resourceName: "mood_4"), color: #colorLiteral(red: 0.9755447507, green: 0.332755357, blue: 0.1311466396, alpha: 1), value: 4, description: "Happy"),
        Mood(image: #imageLiteral(resourceName: "mood_5"), color: #colorLiteral(red: 0.8029490709, green: 0.1766515076, blue: 0.1739873886, alpha: 1), value: 5, description: "Awesome")
    ]
}
