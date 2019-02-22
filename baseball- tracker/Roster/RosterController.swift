//
//  LineUpController.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/21/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import UIKit

class RosterController: UIViewController {
    weak var coordinator: MainCoordiantor?
    
    private var players: [Player] = []
    
    private var rosterView = RosterView()

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
        setupView()
        getRoster()
    }
}

// MARK: - Private Methods
extension RosterController {
    
    fileprivate func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(rosterView)
        rosterView.safeAreaFullScreen(to: view)
        rosterView.tableView.registerCell(PlayerCell.self)
        rosterView.tableView.delegate = self
        rosterView.tableView.dataSource = self
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

// MARK: - Target Actions
extension RosterController {
    
    @objc func submitLineup(_ sender: UIButton) {
        print("Roster Set")
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

// MARK: - UITableViewDelegate Methods
extension RosterController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let numSelected = tableView.indexPathsForSelectedRows?.count ?? 0
        if numSelected > 0 || numSelected < 9 {
            rosterView.updateSubmitText("Select \(9 - numSelected) more Player(s)")
        }
        if numSelected == 9 {
            rosterView.enableSubmit()
            rosterView.updateSubmitText("Submit Lineup")
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let numSelected = tableView.indexPathsForSelectedRows?.count ?? 0
        if numSelected > 0 || numSelected < 9 {
            rosterView.updateSubmitText("Select \(9 - numSelected) more Player(s)")
        }
    }
}

// MARK: - UITableViewDataSource Methods
extension RosterController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as PlayerCell
        cell.playerInfo.text = players[indexPath.item].prepareData()
        return cell
    }
}
