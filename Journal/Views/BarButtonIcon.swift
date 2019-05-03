//
//  BarButtonIcon.swift
//  Journal
//
//  Created by Hai Le on 2/5/19.
//  Copyright © 2019 Hai Le. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class BarButtonIcon: UIBarButtonItem {
    //initWithFrame to init view from code
    override init() {
        super.init()
        setupView()
    }
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    //common func to init our view
    private func setupView() {
        
    }
}
