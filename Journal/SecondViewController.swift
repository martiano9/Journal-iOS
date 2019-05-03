//
//  SecondViewController.swift
//  Journal
//
//  Created by Hai Le on 4/4/19.
//  Copyright © 2019 Hai Le. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationItem.largeTitleDisplayMode = .always
        } }


}

