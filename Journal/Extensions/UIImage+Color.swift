//
//  UIImage+Color.swift
//  Journal
//
//  Created by Hai Le on 11/5/19.
//  Copyright © 2019 Hai Le. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageRenderingMode(_ renderMode: UIImage.RenderingMode) {
        assert(image != nil, "Image must be set before setting rendering mode")
        // AlwaysOriginal as an example
        image = image?.withRenderingMode(.alwaysTemplate)
    }
}
