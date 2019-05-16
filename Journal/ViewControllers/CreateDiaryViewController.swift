//
//  CreateDiaryViewController.swift
//  Journal
//
//  Created by Hai Le on 3/5/19.
//  Copyright © 2019 Hai Le. All rights reserved.
//

import Foundation
import UIKit

class CreateDiaryViewController: UIViewController {
    // MARK: - Constants
    struct Constants {
        static fileprivate let headerHeight: CGFloat = 230
    }
    
    // MARK: - Properties
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headerContainerView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var headerTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var moodImage: UIButton!
    @IBOutlet weak var weatherImage: UIButton!
    @IBOutlet weak var titleText: UITextField!
    private var label: UILabel!
    private var titleTextField: UITextField!
    public var diaryID: Int32 = -1
    
    
    private var headerHeightConstraint1: NSLayoutConstraint!
    
    private var _mood: Mood?
    var mood: Mood? {
        set {
            _mood = newValue
        }
        get { return _mood }
    }
    
    private var _weather: Weather?
    var weather: Weather? {
        set {
            _weather = newValue
        }
        get { return _weather }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Transparent navigation
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        // Initial values
        timeLabel.text = Date().toDateString()
        
        // Update mood
        if (mood != nil) {
            moodImage.setImage(mood?.image, for: .normal)
            moodImage.tintColor = mood?.color
        }
        
        if (diaryID != -1) {
            loadDiary()
        }
    }
    
    @IBAction func cameraPressed(_ sender: Any) {
    }
    
    private func loadDiary() {
        let diary = SQLite.shared.selectDairyBy(Id: diaryID)
        timeLabel.text = diary?.created.toString()
        if let m = diary?.mood {
            mood = Mood.list[Int(m) - 1]
        }
       
        if (diary?.mood != -1) {
            moodImage.setImage(mood?.image, for: .normal)
            moodImage.tintColor = mood?.color
        }
        titleText.text = diary?.title ?? ""
        textView.text = diary?.text
        weather = Weather.list[Int(diary?.weather ?? 0)]
        weatherImage.setImage(weather?.image , for: .normal)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    fileprivate func returnDairyScreen() {
        if self.presentingViewController != nil {
            self.dismiss(animated: true, completion: {
                self.navigationController!.popToRootViewController(animated: true)
            })
        }
        else {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        returnDairyScreen()
    }
    
    @IBAction func donePressed(_ sender: Any) {
        //TODO: Save content here
        
        if (diaryID > 0) {
            SQLite.shared.updateDiary(diary: Diary(ID: diaryID, title: titleText?.text ?? "", location: ""
                ,text: textView?.text ?? "", mood: mood?.value ?? 1, weather: weather?.code ?? 1, isFavorite: false))
        }
        else {
            SQLite.shared.insertDiary(diary: Diary(ID: 0, title: titleText?.text ?? "", location: ""
                ,text: textView?.text ?? "", mood: mood?.value ?? 1, weather: weather?.code ?? 1, isFavorite: false))
        }
        
        returnDairyScreen()
    }
    
    @IBAction func weatherPressed(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Select Weather", message: "Record the weather", preferredStyle: .actionSheet)
        for w in Weather.list {
            let action = UIAlertAction(title: w.title, style: .default) { (action) in
                self.weatherImage.setImage(w.image, for: .normal)
                self.weather = w
            }
    
            action.setValue(w.image, forKey: "image")
            actionSheet.addAction(action)
        }
    
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil) //Will just dismiss the action sheet
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func moodPressed(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Select Mood", message: "Recrod your mood", preferredStyle: .actionSheet)
        for w in Mood.list {
            let action = UIAlertAction(title: w.description, style: .default) { (action) in
                self.moodImage.setImage(w.image, for: .normal)
                self.moodImage.tintColor = w.color
                self.mood = w
            }
            
            action.setValue(w.image, forKey: "image")
            actionSheet.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil) //Will just dismiss the action sheet
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true, completion: nil)
    }
}

private extension CreateDiaryViewController {
    
}
