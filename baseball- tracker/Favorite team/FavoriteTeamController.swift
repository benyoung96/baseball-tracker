//
//  FavoriteTeamController.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/22/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import UIKit

class FavoriteTeamController: UITableViewController {
    weak var coordinator: MainCoordiantor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Private Methods


// MARK: - ControllerType Methods
extension FavoriteTeamController: ControllerType {
    
    static func create() -> UIViewController {
        let vc = FavoriteTeamController()
        return vc
    }
}

// MARK: - UITableViewDelegate Methods
extension FavoriteTeamController {
    
}

// MARK: - UITableViewDataSource Methods
extension FavoriteTeamController {
    
}
