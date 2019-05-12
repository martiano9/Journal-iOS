//
//  AspectButton.swift
//  Journal
//
//  Created by Hai Le on 12/5/19.
//  Copyright © 2019 Hai Le. All rights reserved.
//

import Foundation
import UIKit

class TRAspectButton : UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    override func layoutSubviews() {
        self.imageView?.contentMode = .scaleAspectFill
        self.contentHorizontalAlignment = .fill
        self.contentVerticalAlignment = .fill
        super.layoutSubviews()
    }
}
