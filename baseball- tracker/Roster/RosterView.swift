//
//  RosterView.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/22/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import UIKit

class RosterView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
        addSubview(tableView)
        addSubview(submit)
        
        addConstraints([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            submit.bottomAnchor.constraint(equalTo: bottomAnchor),
            submit.leadingAnchor.constraint(equalTo: leadingAnchor),
            submit.trailingAnchor.constraint(equalTo: trailingAnchor),
            submit.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.bottomAnchor.constraint(equalTo: submit.topAnchor)
        ])
    }
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.allowsMultipleSelection = true
        tableView.allowsMultipleSelectionDuringEditing = true
        return tableView
    }()
    
    let submit: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Select Line up", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .red
        button.isEnabled = false
        button.addTarget(self, action: #selector(RosterController.submitLineup(_:)), for: .touchUpInside)
        return button
    }()
}

// MARK: - Methods to update view
extension RosterView {
    
    func hideSubmit() {
        submit.isHidden = true
    }
    
    func showSubmit() {
        submit.isHidden = false
    }
    
    func enableSubmit() {
        submit.isEnabled = true
    }
    
    func disableSubmit() {
        submit.isEnabled = false
    }
    
    func updateSubmitText(_ text: String) {
        submit.setTitle(text, for: .normal)
    }
}
