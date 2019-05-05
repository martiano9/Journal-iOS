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
    
    static var list: [Mood] = [
        Mood(image: #imageLiteral(resourceName: "mood_1"), color: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), value: 1),
        Mood(image: #imageLiteral(resourceName: "mood_2"), color: #colorLiteral(red: 0.9991070628, green: 0.3719444573, blue: 0.1845107973, alpha: 1), value: 2),
        Mood(image: #imageLiteral(resourceName: "mood_3"), color: #colorLiteral(red: 0.9829123616, green: 0.645016849, blue: 0.08967169374, alpha: 1), value: 3),
        Mood(image: #imageLiteral(resourceName: "mood_4"), color: #colorLiteral(red: 0.9349493384, green: 0.8629651666, blue: 0.000320550811, alpha: 1), value: 4),
        Mood(image: #imageLiteral(resourceName: "mood_5"), color: #colorLiteral(red: 0.4555985332, green: 0.843102932, blue: 0.008411763236, alpha: 1), value: 5)
    ]
}
