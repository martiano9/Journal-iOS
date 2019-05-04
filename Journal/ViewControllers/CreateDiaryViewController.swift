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
    private var label: UILabel!
    private var titleTextField: UITextField!
    
    private var headerHeightConstraint1: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Transparent navigation
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        // Initial values
        timeLabel.text = Date().toDateString()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

private extension CreateDiaryViewController {
    
}

extension CreateDiaryViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        if contentOffsetY < 0.0 {
            headerHeightConstraint?.constant = Constants.headerHeight - scrollView.contentOffset.y
            headerTopConstraint?.constant = contentOffsetY
        } else {
            let parallaxFactor: CGFloat = 0.25
            let offsetY = contentOffsetY * parallaxFactor
            let minOffsetY: CGFloat = 8.0
            let availableOffset = min(offsetY, minOffsetY)
            let contentRectOffsetY = availableOffset / Constants.headerHeight
            headerTopConstraint?.constant = 0
            headerImageView.layer.contentsRect = CGRect(x: 0, y: -contentRectOffsetY, width: 1, height: 1)
            headerHeightConstraint?.constant = Constants.headerHeight
        }
        
        // Navigationbar animation
        let offset = contentOffsetY / (Constants.headerHeight / 2)
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: min(offset, 1))
        UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: min(offset, 1))
    }
}
