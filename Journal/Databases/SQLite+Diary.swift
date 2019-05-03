//
//  SQLiteDatabase+Diary.swift
//  Journal
//
//  Created by Hai Le on 2/5/19.
//  Copyright © 2019 Hai Le. All rights reserved.
//

import Foundation
import SQLite3

extension SQLite {
    public func createTables() {
        print("creating tables from extension")
        // Creating tables
        createDiaryTable()
    }
    
    public func dropTables() {
        // Dropping tables
        dropTable(tableName:"Diary")
    }
    
    private func createDiaryTable() {
        let createQuery = """
            CREATE TABLE Diary (
                  Id INTEGER PRIMARY KEY NOT NULL,
                  Title VARCHAR(255) NOT NULL,
                  Text TEXT,
                  Location VARCHAR(255),
                  Mood INTEGER,
                  Weather INTEGER,
                  IsFavorite BOOLEAN NOT NULL DEFAULT 0,
                  Image BLOB,
                  Created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                  Edited DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
            );
        """
        createTableWithQuery(createQuery, tableName: "Diary")
    }
    
    public func insertDiary(diary: Diary) {
        let insertQuery = """
            INSERT INTO Diary (
                Id, Title, Text, Location, Mood, Weather, IsFavorite, Image)
                VALUES (?, ?, ?, ?, ?, ? , ?, ?);
        """
        insertWithQuery(insertQuery, bindingFunction: { (insertStatement) in
            sqlite3_bind_int(insertStatement, 1, diary.ID)
            sqlite3_bind_text(insertStatement, 2, NSString(string:diary.title).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, NSString(string:diary.text).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, NSString(string:diary.location).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 5, diary.mood)
            sqlite3_bind_int(insertStatement, 6, diary.weather)
            sqlite3_bind_int(insertStatement, 7, diary.isFavorite.intValue)
//            sqlite3_bind_blob(insertStatement, 8, diary.image?.bytes, Int32(diary.image?.length), nil)
        })
    }
    
    func selectAllDiaries() -> [Diary]
    {
        var result = [Diary]()
        let selectQuery = "SELECT * FROM Diary"
        selectWithQuery(selectQuery, eachRow: { (row) in
            //create a movie object from each result
            let movie = Diary(
                ID: sqlite3_column_int(row, 0),
                title: String(cString:sqlite3_column_text(row, 1)),
                location: String(cString:sqlite3_column_text(row, 3)),
                text: String(cString:sqlite3_column_text(row, 2)),
                mood: sqlite3_column_int(row, 4)
            )
            
            //add it to the result array
            result += [movie]
        })
        return result
    }
}

