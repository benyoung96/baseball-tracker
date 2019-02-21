//
//  LineUpController.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/21/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import UIKit

class RosterController: UITableViewController {
    weak var coordinator: MainCoordiantor?
    
    private var players: [Player] = []

    private let networkManager: RosterNetworkManager
    
    init(_ networkManager: RosterNetworkManager) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getRoster()
    }
}

// MARK: - Private Methods
extension RosterController {
    
    fileprivate func setupTableView() {
        
    }
    
    fileprivate func getRoster() {
        networkManager.getRoster("yankees") { (players, error) in
            if error != nil {
                print(error as Any)
            }
            
            if let players = players {
                self.players = players
            }
        }
    }
}

// MARK: - ControllerType Methods
extension RosterController: ControllerType {
    
    static func create() -> UIViewController {
        let networkManager = RosterNetworkManager()
        let vc = RosterController(networkManager)
        return vc
    }
}
