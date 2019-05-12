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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func backPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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
