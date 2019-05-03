//
//  WeatherHeader.swift
//  Journal
//
//  Created by Hai Le on 1/5/19.
//  Copyright © 2019 Hai Le. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class WeatherHeader: UIView {
    // Title
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        titleLabel.text = "Add a diary"
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.Theme.Text.A100
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    // Rounded Background
    lazy var headerView: UIView = {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.init(hex: 0xFFFFFF)
        headerView.addSubview(titleLabel)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()
    
    //initWithFrame to init view from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    //common func to init our view
    private func setupView() {
        backgroundColor = .clear
        addSubview(headerView)
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            //pin headerTitle to headerView
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            
            //pin headerView to top
            headerView.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
