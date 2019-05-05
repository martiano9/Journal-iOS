//
//  Weather.swift
//  Journal
//
//  Created by Hai Le on 5/5/19.
//  Copyright © 2019 Hai Le. All rights reserved.
//

import Foundation
import UIKit

struct Weather {
    var image: UIImage
    var title: String
    var code: Int32
    
    static var list: [Weather] = [
        Weather(image: #imageLiteral(resourceName: "weather_cloudy"), title: "Cloudy", code: 0),
        Weather(image: #imageLiteral(resourceName: "weather_fog_day"), title: "Fog Day", code: 1),
        Weather(image: #imageLiteral(resourceName: "weather_fog_night"), title: "Fog Night", code: 2),
        Weather(image: #imageLiteral(resourceName: "weather_hail"), title: "Hail", code: 3),
        Weather(image: #imageLiteral(resourceName: "weather_lighting"), title: "Lightning", code: 4),
        Weather(image: #imageLiteral(resourceName: "weather_rainy"), title: "Rainy", code: 5),
        Weather(image: #imageLiteral(resourceName: "weather_snow"), title: "Snow", code: 6),
        Weather(image: #imageLiteral(resourceName: "weather_sunny"), title: "Sunny", code: 7),
        Weather(image: #imageLiteral(resourceName: "weather_windy"), title: "Windy", code: 8),
    ]
}
