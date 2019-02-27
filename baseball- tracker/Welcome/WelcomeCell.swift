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
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(image)
        
        addConstraints([
            image.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 25),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75),
            image.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75),
            
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 65),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.75)
        ])
    }
    
    let image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "main")
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(25)
        label.textColor = .welcomeGray
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(15)
        label.textAlignment = .center
        label.textColor = .welcomeDarkGray
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
}
