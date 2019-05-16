//
//  CreateMoodViewController.swift
//  Journal
//
//  Created by Hai Le on 11/5/19.
//  Copyright © 2019 Hai Le. All rights reserved.
//

import UIKit

class CreateMoodViewController: UIViewController {
    var moodId: Int = 0
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var addNoteButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Transparent navigation
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        UIApplication.shared.statusBarView?.backgroundColor = .white
        
        // Set date label
        dateButton.setTitle(Date().toDateString(), for: .normal)
        
        // Close button
        closeButton.backgroundColor = .clear
        closeButton.layer.cornerRadius = 16
        closeButton.layer.borderWidth = 2
        closeButton.layer.borderColor = UIColor.black.cgColor
        
    }
    
    @IBAction func donePressed(_ sender: Any) {
        // save journal
        SQLite.shared.insertDiary(diary: Diary(mood: Int32(moodId)))
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func moodPressed(sender:UIButton) {
        moodId = sender.tag
        sender.tintColor = Mood.list.first(where: {$0.value == moodId})?.color
        
        for x in 1...5 {
            let lbl = self.view.viewWithTag(x+10) as? UILabel
            if (x != sender.tag) {
                let btn = self.view.viewWithTag(x) as? UIButton
                btn?.tintColor = #colorLiteral(red: 0.4169229269, green: 0.4723314047, blue: 0.5565609336, alpha: 1)
                
                lbl?.textColor = #colorLiteral(red: 0.4169229269, green: 0.4723314047, blue: 0.5565609336, alpha: 1)
            } else {
                lbl?.textColor = Mood.list.first(where: {$0.value == moodId})?.color
            }
        }
        addNoteButton.isHidden = false
        doneButton.isHidden = false
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AddNoteSegue") {
            let vc = segue.destination as! CreateDiaryViewController
            vc.mood = Mood.list.first(where: {$0.value == moodId})
        }
    }
 

}
