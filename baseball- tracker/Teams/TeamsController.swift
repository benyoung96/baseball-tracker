//
//  FavoriteTeamController.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/22/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import UIKit

class TeamsController: UITableViewController {
    weak var coordinator: MainCoordiantor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

// MARK: - Private Methods
extension TeamsController {
    
    fileprivate func setupViews() {
        view.backgroundColor = .red
    }
}

// MARK: - ControllerType Methods
extension TeamsController: ControllerType {
    
    static func create() -> UIViewController {
        let vc = TeamsController()
        return vc
    }
}

// MARK: - UITableViewDelegate Methods
extension TeamsController {
    
}

// MARK: - UITableViewDataSource Methods
extension TeamsController {
    
}
