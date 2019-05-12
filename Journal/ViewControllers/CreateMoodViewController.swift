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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Transparent navigation
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
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func moodPressed(sender:UIButton)
    {
        moodId = sender.tag
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let selectedMood = Mood.list[moodId-1]
        let vc = segue.destination as! ConfirmMoodViewController
        vc.view.backgroundColor = UIColor.white
        vc.moodLabel.text = "I feel \(selectedMood.description)"
        vc.moodLabel.textColor = selectedMood.color
        vc.moodImage.image = selectedMood.image
        vc.moodImage.tintColor = selectedMood.color
//        confirmMoodVC.transitioningDelegate = self
//        confirmMoodVC.modalPresentationStyle = .custom
    }
 

}
