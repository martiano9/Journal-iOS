//
//  MyDiaryTableViewController.swift
//  Journal
//
//  Created by Hai Le on 2/5/19.
//  Copyright © 2019 Hai Le. All rights reserved.
//

import Foundation
import UIKit

class DiaryTableViewController: UITableViewController {
    var diaries = [Diary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        diaries = SQLite.shared.selectAllDiaries()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 340
        
        // Do any additional setup after loading the view.
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.topItem?.title = "My Diary"
            navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        }
    }
    
    // MARK: - Table View Datasource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diaries.count
    }
    
    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let diary = diaries[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if let diaryCell = cell as? DiaryTableViewCell {
            diaryCell.data = diary
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            tableView.beginUpdates()
            //            Names.removeAtIndex(indexPath!.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    // Navigation Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if (segue.identifier == "ShowDetail") {
            guard let detailViewController = segue.destination as? DiaryDetailViewController else {
                fatalError("Unexpeted Error")
            }
            guard let selectedCell = sender as? DiaryTableViewCell else {
                fatalError("Unexpeted Error")
            }
            guard let indexPath = tableView.indexPath(for: selectedCell) else {
                fatalError("Unexpeted Error")
            }
            
            let selectedDiary = diaries[indexPath.row]
            detailViewController.diary = selectedDiary
        }
    }
}
