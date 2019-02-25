//
//  OnBoardingCell.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/24/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import UIKit

class OnBoardingCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
        layer.cornerRadius = 5.0
        backgroundColor = .lightGray
        
        addSubview(title)
        addConstraints([
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
}
