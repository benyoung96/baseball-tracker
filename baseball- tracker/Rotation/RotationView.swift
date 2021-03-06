//
//  RotationCell.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/24/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import UIKit

class RotationView: UIView {
    
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
        addSubview(direction)
        addSubview(tableView)
        
        addConstraints([
            title.topAnchor.constraint(equalTo: topAnchor),
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            direction.bottomAnchor.constraint(equalTo: bottomAnchor),
            direction.centerXAnchor.constraint(equalTo: centerXAnchor),
            direction.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            direction.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: direction.topAnchor, constant: -10),
            tableView.centerXAnchor.constraint(equalTo: centerXAnchor),
            tableView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.70)
        ])
    }
    
    let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Choose your Rotation"
        label.textColor = .welcomeGray
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.allowsMultipleSelection = true
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    let direction: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.welcomeGray, for: .normal)
        button.addTarget(self, action: #selector(RotationController.submitLineUpRotation(_:)), for: .touchUpInside)
        return button
    }()
}
