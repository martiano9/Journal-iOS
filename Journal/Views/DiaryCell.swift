//
//  DiaryTableViewCell.swift
//  Journal
//
//  Created by Hai Le on 2/5/19.
//  Copyright © 2019 Hai Le. All rights reserved.
//

import Foundation
import UIKit

class DiaryCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet var thumbnailAspectRatio: NSLayoutConstraint!
    @IBOutlet weak var thumbnailHeight: NSLayoutConstraint!
    @IBOutlet weak var moodImage: UIButton!
    @IBOutlet weak var weatherImage: UIImageView!
    
    var data: Diary! {
        didSet {
            self.lblTitle.text = data.title
            self.lblText.text = data.text
            self.lblTime.text = data.created.toDateString(withFormat: "HH:mm")
            
            if let imageData = data.image {
                let stringdata = String(data: imageData as Data, encoding: String.Encoding.utf8)
                if let dataDecoded:NSData = NSData(base64Encoded: stringdata!, options: NSData.Base64DecodingOptions(rawValue: 0)) {
                    thumbnailImage.image = UIImage(data: dataDecoded as Data)
                    thumbnailAspectRatio.isActive = true
                    thumbnailHeight.constant = 240
                }
            } else {
                thumbnailAspectRatio.isActive = false
                thumbnailHeight.constant = 0
            }
            // Set mood Icon
            let moodIdx: Int = Int(data.mood - 1)
            moodImage.setImage(Mood.list[moodIdx].image, for: .normal)
            moodImage.tintColor = .white
            moodImage.layer.cornerRadius = 5
            moodImage.backgroundColor = Mood.list[moodIdx].color
            
            // Set weather Icon
            let weatherIdx: Int = Int(data.weather)
            if (weatherIdx != -1) {
                weatherImage.image = Weather.list[weatherIdx].image
            }
            
            // Title
            if (data.title == "") {
                lblTitle.text = "Feeling \(Mood.list[moodIdx].description)"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // lblText.font = .boldSystemFont(ofSize: 16)
    }
}
