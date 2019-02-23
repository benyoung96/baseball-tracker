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
            print("showing on boarding")
            showOnBoarding()
        } else {
            print("showing the schedule")
            if let team = userConfig.getFavoriteTeam() {
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
    
    func getOnBoardingControllers() -> [UIViewController] {
        let teams = TeamsController.create() as! TeamsController
        let lineUp = LineUpController.create() as! LineUpController
        let rotation = RotationController.create() as! RotationController
        return [teams, lineUp, rotation]
    }
    
    func showTeamSchedule(_ team: String) {
        let vc = ScheduleController.create() as! ScheduleController
        vc.navigationItem.title = team
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showRoster() {
        let vc = LineUpController.create() as! LineUpController
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
