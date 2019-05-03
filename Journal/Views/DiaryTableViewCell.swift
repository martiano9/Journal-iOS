//
//  DiaryTableViewCell.swift
//  Journal
//
//  Created by Hai Le on 2/5/19.
//  Copyright © 2019 Hai Le. All rights reserved.
//

import Foundation
import UIKit

class DiaryTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var thumbnailAspectRatio: NSLayoutConstraint!
    @IBOutlet weak var thumbnailHeight: NSLayoutConstraint!
    
    var data: Diary! {
        didSet {
            self.lblTitle.text = data.title
            self.lblText.text = data.text
            self.lblTime.text = data.created.toString()
            if let imageData = data.image {
                self.thumbnailImage.image = UIImage(data: imageData as Data)
            } else {
                self.thumbnailImage.removeConstraint(thumbnailAspectRatio)
                self.thumbnailHeight.constant = 0
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // lblText.font = .boldSystemFont(ofSize: 16)
    }
}
