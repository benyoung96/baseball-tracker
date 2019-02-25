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
        if !userConfig.isFirstBoot() {
            navigationController.isNavigationBarHidden = true
            showOnBoarding()
        } else {
            if let team = userConfig.getFavoriteTeam() {
                navigationController.isNavigationBarHidden = false
                showTeamSchedule(team)
            }
        }
    }
    
    func showOnBoarding() {
        let vc = OnBoardingController.create() as! OnBoardingController
        vc.coordinator = self
        vc.pages = getOnBoardingControllers()
        navigationController.pushViewController(vc, animated: false)
    }
    
    private func getOnBoardingControllers() -> [UIViewController] {
        let teams = TeamsController.create(container) as! TeamsController
        let lineUp = LineUpController.create(container) as! LineUpController
        let rotation = RotationController.create(container) as! RotationController
        return [teams, lineUp, rotation]
    }
    
    func showTeamSchedule(_ team: String) {
        let vc = ScheduleController.create(container) as! ScheduleController
        vc.navigationItem.title = team
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showRoster() {
        let vc = LineUpController.create(container) as! LineUpController
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
