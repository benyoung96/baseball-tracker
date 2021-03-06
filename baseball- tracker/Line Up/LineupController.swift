//
//  LineUpController.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/21/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import UIKit
import CoreData

class LineUpController: UIViewController {
    weak var coordinator: MainCoordiantor?
    
    private var positionPlayers: [Player] = []
    private var selectedPlayers: [Player] = []
    private var team: Team?
    
    private var lineUpView = LineUpView()

    private var networkManager: LineUpNetworkManager
    private let container: NSPersistentContainer
    
    init(_ networkManager: LineUpNetworkManager, _ container: NSPersistentContainer) {
        self.networkManager = networkManager
        self.container = container
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setupView()
        getRoster()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let name = UserConfig().getFavoriteTeam() ?? ""
        Team.getTeam(from: container.viewContext, name: name) { (team) in
            self.team = team.last
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        PositionPlayer.saveLineUp(into: container.viewContext, players: positionPlayers, selected: &selectedPlayers, team: team!)
    }
}

// MARK: - Private Methods
extension LineUpController {
    
    fileprivate func setupView() {
        view.backgroundColor = .welcomeBackground
        
        view.addSubview(lineUpView)
        lineUpView.safeAreaFullScreen(to: view)
        lineUpView.tableView.registerCell(SetupCell.self)
        lineUpView.tableView.delegate = self
        lineUpView.tableView.dataSource = self
    }
    
    fileprivate func getRoster() {
        networkManager.getRoster("yankees") { (players, error) in
            if error != nil {
                print(error as Any)
            }
            
            if let players = players {
                self.positionPlayers = players.filter{ $0.position != "P" }
                DispatchQueue.main.async {
                    self.lineUpView.tableView.reloadData()
                }
            }
        }
    }
}

// MARK: - ControllerType Methods
extension LineUpController: ControllerType {
    
    static func create(_ container: NSPersistentContainer) -> UIViewController {
        let networkManager = LineUpNetworkManager()
        let vc = LineUpController(networkManager, container)
        return vc
    }
}

// MARK: - UITableViewDelegate Methods
extension LineUpController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView.indexPathsForSelectedRows?.count ?? 0) < 10 {
            selectedPlayers.append(positionPlayers[indexPath.section])
            let cell: SetupCell = tableView.cellForRow(at: indexPath) as! SetupCell
            cell.slot.text = "\(selectedPlayers.count)"
        } else {
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedPlayers.removeLast()
        let cell: SetupCell = tableView.cellForRow(at: indexPath) as! SetupCell
        cell.slot.text = ""
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
}

// MARK: - UITableViewDataSource Methods
extension LineUpController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return positionPlayers.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as SetupCell
        cell.title.text = positionPlayers[indexPath.section].prepareData()
        return cell
    }
}
