//
//  DiaryDetailViewController.swift
//  Journal
//
//  Created by Hai Le on 9/5/19.
//  Copyright © 2019 Hai Le. All rights reserved.
//

import UIKit

class DiaryDetailViewController: UIViewController {
    var diary: Diary?
    @IBOutlet weak var LblTime: UILabel!
    @IBOutlet weak var LblText: UITextView!
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var BtnEdit: UIBarButtonItem!
    
    @IBOutlet weak var weatherBtn: UIButton!
    @IBOutlet weak var moodBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if (diary?.title == "" && diary != nil) {
            let moodIdx: Int = Int(diary!.mood - 1)
            self.title = "Feeling \(Mood.list[moodIdx].description)"
        } else {
            self.title = diary?.title
        }
        
        // Update mood icon
        let mood = Mood.list.first(where: {$0.value == diary?.mood})
        if (mood != nil) {
            moodBtn.setImage(mood?.image, for: .normal)
            moodBtn.tintColor = mood?.color
        }
        // Update weather
        let weather = Weather.list.first(where: {$0.code == diary?.weather})
        if (weather != nil) {
            weatherBtn.setImage(weather?.image, for: .normal)
        }
        
        LblTime.text=diary?.created.toString()
        
        if let imageData = diary?.image {
            self.Image.image = UIImage(data: imageData as Data)
        } else {
           
        }
        
        // Text
        self.LblText.text = diary?.text ?? ""
        
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        if let diaryID = diary?.ID {
            let alert = UIAlertController(title: "Delete Diary", message: "Do you want to delete this diary? This action cannot be undone!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                SQLite.shared.deleteDiary(Id: diaryID)
                self.returnToRoot()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    func returnToRoot() {
        if self.presentingViewController != nil {
            self.dismiss(animated: true, completion: {
                self.navigationController!.popToRootViewController(animated: true)
            })
        }
        else {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if (segue.identifier == "EditDiary") {
            guard let createDiaryViewController = segue.destination as? CreateDiaryViewController else {
                fatalError("Unexpeted Error")
            }
            createDiaryViewController.title = "Edit Diary"
            createDiaryViewController.diaryID = diary?.ID ?? 0
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
