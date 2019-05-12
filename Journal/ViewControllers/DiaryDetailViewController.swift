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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        LblTitle.text = diary?.title
        LblTime.text=diary?.created.toString()
        LblText.text=diary?.text
        if let imageData = diary?.image {
            self.Image.image = UIImage(data: imageData as Data)
        } else {
           
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
