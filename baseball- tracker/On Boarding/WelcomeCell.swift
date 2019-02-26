//
//  WelcomeView.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/25/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import UIKit

class WelcomeCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .welcomeBackground
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
        let controlsStackView = UIStackView(arrangedSubviews: [prevButton, pageControll, nextButton])
        controlsStackView.translatesAutoresizingMaskIntoConstraints = false
        controlsStackView.distribution = .fillEqually
        
        addSubview(controlsStackView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addConstraints([
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 65),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.75),
            
            controlsStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            controlsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            controlsStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(25)
        label.textColor = .welcomeGray
        label.text = "Baseball Tracker"
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(15)
        label.textAlignment = .center
        label.textColor = .welcomeDarkGray
        label.text = "Keep track of batting, pitching and defence statistics throughout the regular season."
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let prevButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("PREV", for: .normal)
        return button
    }()
    
    let pageControll: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 3
        return pc
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.setTitleColor(.welcomeGray, for: .normal)
        button.setTitle("NEXT", for: .normal)
        return button
    }()
}
