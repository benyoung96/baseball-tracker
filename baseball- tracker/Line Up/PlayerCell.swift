//
//  PlayerCell.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/22/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import UIKit

class PlayerCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView() {
        layer.cornerRadius = 5.0
        backgroundColor = .lightGray
        
        addSubview(playerInfo)
        addConstraints([
            playerInfo.centerXAnchor.constraint(equalTo: centerXAnchor),
            playerInfo.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    let playerInfo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
}
