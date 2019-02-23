//
//  LineUpController.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/21/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import UIKit

class LineUpController: UIViewController {
    weak var coordinator: MainCoordiantor?
    
    private var players: [Player] = []
    
    private var lineUpView = LineUpView()

    private let networkManager: LineUpNetworkManager
    
    init(_ networkManager: LineUpNetworkManager) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
//        setupView()
//        getRoster()
    }
}

// MARK: - Private Methods
extension LineUpController {
    
    fileprivate func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(lineUpView)
        lineUpView.safeAreaFullScreen(to: view)
        lineUpView.tableView.registerCell(PlayerCell.self)
        lineUpView.tableView.delegate = self
        lineUpView.tableView.dataSource = self
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
extension LineUpController {
    
    @objc func submitLineup(_ sender: UIButton) {
        print("Roster Set")
    }
}

// MARK: - ControllerType Methods
extension LineUpController: ControllerType {
    
    static func create() -> UIViewController {
        let networkManager = LineUpNetworkManager()
        let vc = LineUpController(networkManager)
        return vc
    }
}

// MARK: - UITableViewDelegate Methods
extension LineUpController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let numSelected = tableView.indexPathsForSelectedRows?.count ?? 0
        lineUpView.updateSelected(numSelected)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let numSelected = tableView.indexPathsForSelectedRows?.count ?? 0
        lineUpView.updateDeselected(numSelected)
    }
}

// MARK: - UITableViewDataSource Methods
extension LineUpController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as PlayerCell
        cell.playerInfo.text = players[indexPath.item].prepareData()
        return cell
    }
}
