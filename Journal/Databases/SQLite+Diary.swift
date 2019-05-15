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
                  Title VARCHAR(255),
                  Text TEXT,
                  Location VARCHAR(255),
                  Mood INTEGER NOT NULL,
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
                INSERT INTO Diary (Title, Text, Location, Mood, Weather, IsFavorite, Created)
                VALUES (?,?,?,?,?,?,?)
        """
        insertWithQuery(insertQuery, bindingFunction: { (insertStatement) in
            //sqlite3_bind_int(insertStatement, 1, diary.ID)
            sqlite3_bind_text(insertStatement, 1, NSString(string:diary.title).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, NSString(string:diary.text).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, NSString(string:diary.location).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 4, diary.mood)
            sqlite3_bind_int(insertStatement, 5, diary.weather)
            sqlite3_bind_int(insertStatement, 6, diary.isFavorite.intValue)
            sqlite3_bind_text(insertStatement, 7, NSString(string:diary.created.toDateString()).utf8String, -1, nil)
//            sqlite3_bind_blob(insertStatement, 8, diary.image?.bytes, Int32(diary.image?.length), nil)
        })
    }
    
    public func updateDiary(diary: Diary) {
        let query = """
            Update Diary set
                Title = ?, Text = ?, Location = ?, Mood = ?, Weather = ?, IsFavorite = ?, Image = ?,
                Edited = CURRENT_TIMESTAMP where Id=?;
        """
        updateWithQuery(query, bindingFunction: { (statement) in
            
            sqlite3_bind_text(statement, 1, NSString(string:diary.title).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, NSString(string:diary.text).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, NSString(string:diary.location).utf8String, -1, nil)
            sqlite3_bind_int(statement, 4, diary.mood)
            sqlite3_bind_int(statement, 5, diary.weather)
            sqlite3_bind_int(statement, 6, diary.isFavorite.intValue)
            if let len=diary.image?.count {
                sqlite3_bind_blob(statement, 7, diary.image?.bytes, Int32(len), nil)
            }
            else {
                sqlite3_bind_blob(statement, 7, diary.image?.bytes, 0, nil)
            }
            //sqlite3_bind_blob(statement, 7, diary.image)
            sqlite3_bind_int(statement, 8, diary.ID)
            //            sqlite3_bind_blob(insertStatement, 8, diary.image?.bytes, Int32(diary.image?.length), nil)
        })
    }
    
    public func deleteDiary(Id: Int32) {
        let Query = """
            delete from Diary where Id=?;
        """
        deleteWithQuery(Query, bindingFunction: { (statement) in
            sqlite3_bind_int(statement, 1, Id)
        })
    }
    
    func selectAllDiaries(query q:String = "SELECT * FROM Diary ORDER BY Created DESC") -> [Diary]
    {
        var result = [Diary]()
        let selectQuery = q
        selectWithQuery(selectQuery, eachRow: { (row) in
            //create a movie object from each result
            var dairy = Diary(
                ID: sqlite3_column_int(row, 0),
                title: String(cString:sqlite3_column_text(row, 1)),
                location: String(cString:sqlite3_column_text(row, 3)),
                text: String(cString:sqlite3_column_text(row, 2)),
                mood: sqlite3_column_int(row, 4),
                weather: sqlite3_column_int(row, 5),
                isFavorite: (sqlite3_column_int(row, 6) as NSNumber).boolValue,
                image: nil,
                created: String(cString:sqlite3_column_text(row, 8)).toDate()
            )
            let len = sqlite3_column_bytes(row, 7)
            let point = sqlite3_column_blob(row, 7)
            if point != nil {
                dairy.image = NSData(bytes: point, length: Int(len))
            }
            
            //add it to the result array
            result += [dairy]
        })
        return result
    }
    
    func diariesHistory() -> [DiaryHistory] {
        var result = [DiaryHistory]()
        let q = "SELECT AVG(Mood) average, MAX(Mood) max, MIN(Mood) min, COUNT(*) count, strftime('%d-%m-%Y', Created) dd FROM Diary WHERE Created BETWEEN '2019-05-01' AND '2019-05-14' GROUP BY dd ORDER BY Created DESC"
        selectWithQuery(q, eachRow: { (row) in
            let history = DiaryHistory(
                Max: sqlite3_column_int(row, 1),
                Min: sqlite3_column_int(row, 2),
                Count: sqlite3_column_int(row, 3),
                Average: sqlite3_column_double(row, 0),
                DateStr: String(cString:sqlite3_column_text(row, 4)))
            result += [history]
        })
        return result
    }
    
    func diariesGroupByDate() -> [DiaryGroup]
    {
        var result = [DiaryGroup]()
        let selectQuery = "select COUNT(*) Count, strftime('%d-%m-%Y', Created) DateStr from Diary group by DateStr ORDER BY Created DESC"
        selectWithQuery(selectQuery, eachRow: { (row) in
            //create a movie object from each result
            let group = DiaryGroup(
                Count: sqlite3_column_int(row, 0),
                DateStr: String(cString:sqlite3_column_text(row, 1)),
                Diaries: selectAllDiaries(query: "SELECT * FROM Diary WHERE strftime('%d-%m-%Y', Created) = '\(String(cString:sqlite3_column_text(row, 1)))' ORDER BY Created DESC")
            )
            //add it to the result array
            result += [group]
        })
        return result
    }
    
    func selectDairyBy(Id:Int32) -> Diary? {
        var result : Diary?
        
        let selectQuery = "SELECT * FROM Diary where Id=?"
        selectWithQuery(selectQuery, eachRow: { (row) in
            var dairy = Diary(
                ID: sqlite3_column_int(row, 0),
                title: String(cString:sqlite3_column_text(row, 1)),
                location: String(cString:sqlite3_column_text(row, 3)),
                text: String(cString:sqlite3_column_text(row, 2)),
                mood: sqlite3_column_int(row, 4),
                weather: sqlite3_column_int(row, 5),
                isFavorite: (sqlite3_column_int(row, 6) as NSNumber).boolValue,
                image: nil
            )
            let len = sqlite3_column_bytes(row, 7)
            let point = sqlite3_column_blob(row, 7)
            if point != nil {
                dairy.image = NSData(bytes: point, length: Int(len))
            }
            
            //add it to the result array
            result = dairy
        },bindingFunction: { (selectQuery) in
            sqlite3_bind_int(selectQuery, 1, Id)
        })
        return result
        
    }
}

