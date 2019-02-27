//
//  WelcomeView.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/26/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import UIKit

class WelcomeView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
        let controlsStackView = UIStackView(arrangedSubviews: [prevButton, pageControl, nextButton])
        controlsStackView.translatesAutoresizingMaskIntoConstraints = false
        controlsStackView.distribution = .fillEqually
        
        addSubview(controlsStackView)
        addConstraints([
            controlsStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            controlsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            controlsStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    let prevButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("PREV", for: .normal)
        button.addTarget(self, action: #selector(WelcomeController.previous(_:)), for: .touchUpInside)
        return button
    }()
    
    let pageControl: UIPageControl = {
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
        button.addTarget(self, action: #selector(WelcomeController.next(_:)), for: .touchUpInside)
        return button
    }()
}
