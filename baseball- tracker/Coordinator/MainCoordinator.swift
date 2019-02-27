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
    private let userConfig = UserConfig()
    
    init(navigationController: UINavigationController, container: NSPersistentContainer) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        userConfig.setFirstBootStatus(false)
        if !userConfig.isFirstBoot() {
            userConfig.setFirstBootStatus(true)
            navigationController.isNavigationBarHidden = true
            showWelcome()
        } else {
            navigationController.isNavigationBarHidden = false
            showTeamSchedule()
        }
    }
    
    func showWelcome() {
        let vc = WelcomeController.create() as! WelcomeController
        vc.coordinator = self
        navigationController.isNavigationBarHidden = true
        navigationController.pushViewController(vc, animated: false)
    }
    
    func popWelcome() {
        navigationController.popToRootViewController(animated: false)
        showTeamSchedule()
    }
    
    func showSetup() {
        let vc = SetupController.create() as! SetupController
        vc.coordinator = self
        vc.pages = setupControllers()
        navigationController.pushViewController(vc, animated: false)
    }
    
    private func setupControllers() -> [UIViewController] {
        let teams = TeamsController.create(container) as! TeamsController
        let lineUp = LineUpController.create(container) as! LineUpController
        let rotation = RotationController.create(container) as! RotationController
        rotation.coordinator = self
        return [teams, lineUp, rotation]
    }
    
    func showTeamSchedule() {
        let vc = ScheduleController.create(container) as! ScheduleController
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showRoster() {
        let vc = LineUpController.create(container) as! LineUpController
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
