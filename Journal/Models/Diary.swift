//
//  Diary.swift
//  Journal
//
//  Created by Hai Le on 2/5/19.
//  Copyright © 2019 Hai Le. All rights reserved.
//

import Foundation

struct Diary {
    var ID: Int32
    var title: String
    var location: String
    var text: String
    var image: NSData?
    var mood: Int32
    var weather: Int32
    var isFavorite: Bool
    var created: Date
    var edited: Date
    
    init(ID: Int32, title: String, location: String, text: String, mood: Int32) {
        self.ID = ID
        self.title = title
        self.location = location
        self.text = text
        self.mood = mood
        self.image = nil
        self.weather = 0
        self.isFavorite = false
        self.created = Date()
        self.edited = Date()
    }
}
