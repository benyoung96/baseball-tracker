//
//  ScheduleView.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/26/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import UIKit

class ScheduleView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
        addSubview(title)
        addSubview(directions)
        addSubview(select)
        
        addConstraints([
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 35),
            
            directions.centerXAnchor.constraint(equalTo: centerXAnchor),
            directions.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            directions.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.75),
            
            select.centerXAnchor.constraint(equalTo: centerXAnchor),
            select.topAnchor.constraint(equalTo: directions.bottomAnchor, constant: 20),
            select.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45)
        ])
    }
    
    let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No Favorite Team Selected"
        label.textColor = .darkGray
        label.font = label.font.withSize(18)
        return label
    }()
    
    let directions: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tap the button below to select your favorite team and setup your everyday line up and starting rotation"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .welcomeDarkGray
        label.textAlignment = .center
        label.font = label.font.withSize(14)
        return label
    }()
    
    let select: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Select Team", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .welcomeBackground
        button.layer.cornerRadius = 3.0
        button.addTarget(self, action: #selector(ScheduleController.selectFavoriteTeam(_:)), for: .touchUpInside)
        return button
    }()
}
