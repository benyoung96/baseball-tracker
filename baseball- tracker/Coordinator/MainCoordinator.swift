//
//  MainCoordinator.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/20/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import UIKit

class MainCoordiantor: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ScheduleController.create() as! ScheduleController
        vc.navigationItem.title = "Yankees"
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showRoster() {
        let vc = RosterController.create() as! RosterController
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
