//
//  FavoriteTeamController.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/22/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import UIKit
import CoreData

class TeamsController: UIViewController {
    weak var coordinator: MainCoordiantor?
    private let teamsView = TeamsView()
    private var teams: [TeamJSON] = []
    private var selectedTeam: TeamJSON?
    
    private var networkManager: TeamsNetworkManager
    private let container: NSPersistentContainer
    
    init(_ networkManager: TeamsNetworkManager, _ container: NSPersistentContainer) {
        self.networkManager = networkManager
        self.container = container
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchTeams()
    }
}

// MARK: - Private Methods
extension TeamsController {
    
    fileprivate func setupViews() {
        view.backgroundColor = .welcomeBackground
        view.addSubview(teamsView)
        teamsView.safeAreaFullScreen(to: view)
        teamsView.tableView.registerCell(SetupCell.self)
        teamsView.tableView.delegate = self
        teamsView.tableView.dataSource = self
    }
    
    fileprivate func fetchTeams() {
        networkManager.getTeams { (teams, error) in
            if error != nil {
                print(error as Any)
            }
            if let teams = teams {
                self.teams = teams
                self.saveTeams(teams: teams)
                DispatchQueue.main.async {
                    self.teamsView.tableView.reloadData()
                }
            }
        }
    }
    
    fileprivate func saveTeams(teams: [TeamJSON]) {
        for team in teams {
            _ = Team.insert(into: container.viewContext, teamJSON: team)
        }
    }
}

// MARK: - ControllerType Methods
extension TeamsController: ControllerType {
    
    static func create(_ container: NSPersistentContainer) -> UIViewController {
        let networkManager = TeamsNetworkManager()
        let vc = TeamsController(networkManager, container)
        return vc
    }
}

// MARK: - UITableViewDelegate Methods
extension TeamsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedTeam == nil {
            UserConfig().saveFavoriteTeam(teams[indexPath.item].name)
        } else {
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if selectedTeam != nil && selectedTeam!.name == teams[indexPath.item].name {
            selectedTeam = nil
        }
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

extension TeamsController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as SetupCell
        cell.title.text = teams[indexPath.section].prepareForView()
        return cell
    }
}
