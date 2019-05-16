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
    @IBOutlet weak var LblTitle: UILabel!
    @IBOutlet weak var LblText: UITextView!
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var BtnEdit: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if (diary?.title == "" && diary != nil) {
            let moodIdx: Int = Int(diary!.mood - 1)
            self.title = "Feeling \(Mood.list[moodIdx].description)"
            LblTitle.text = "Feeling \(Mood.list[moodIdx].description)"
        } else {
            self.title = diary?.title
            LblTitle.text = diary?.title
        }
        
        LblTime.text=diary?.created.toString()
        LblText.text=diary?.text
        if let imageData = diary?.image {
            self.Image.image = UIImage(data: imageData as Data)
        } else {
           
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if (segue.identifier == "EditDiary") {
            guard let createDiaryViewController = segue.destination as? CreateDiaryViewController else {
                fatalError("Unexpeted Error")
            }
            
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
