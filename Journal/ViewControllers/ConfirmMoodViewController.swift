//
//  ConfirmMoodViewController.swift
//  Journal
//
//  Created by Hai Le on 12/5/19.
//  Copyright © 2019 Hai Le. All rights reserved.
//

import UIKit

class ConfirmMoodViewController: UIViewController {
    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var moodImage: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    
    private var _mood: Mood?
    var mood: Mood? {
        didSet {
            if let desc = mood?.description {
                moodLabel?.text = "I feel \(desc)"
                moodLabel?.textColor = mood?.color
                moodImage?.image = mood?.image
                moodImage?.tintColor = mood?.color
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Transparent navigation
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        // Back button
        backButton.backgroundColor = .clear
        backButton.layer.cornerRadius = 16
        backButton.layer.borderWidth = 2
        backButton.layer.borderColor = UIColor.black.cgColor
        
        // Update mood
        if (mood != nil) {
            moodLabel.text = "I feel \(mood?.description ?? "")"
            moodLabel.textColor = mood?.color
            moodImage.image = mood?.image
            moodImage.tintColor = mood?.color
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func donePressed(_ sender: Any) {
        
        // save journal
        if let m=mood?.value {
            //SQLite.shared.insertDiary(diary: Diary(ID: 11, title: "test", location: "test"
            //    ,text: "test", mood: m, weather: 1, isFavorite: false))
            SQLite.shared.insertDiary(diary: Diary(mood: m))
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "AddNoteSegue") {
            let vc = segue.destination as! CreateDiaryViewController
            vc.mood = mood
        }
    }

}
