//
//  MainCoordinator.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/20/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import UIKit
import CoreData

class MainCoordiantor: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var container: NSPersistentContainer
    
    init(navigationController: UINavigationController, container: NSPersistentContainer) {
        self.navigationController = navigationController
        self.container = container
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
