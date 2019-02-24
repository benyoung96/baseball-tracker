//
//  FavoriteTeamController.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/22/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import UIKit

class TeamsController: UIViewController {
    weak var coordinator: MainCoordiantor?
    
    private let teamsView = TeamsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

// MARK: - Private Methods
extension TeamsController {
    
    fileprivate func setupViews() {
        view.backgroundColor = .teamsBackground
        view.addSubview(teamsView)
        teamsView.safeAreaFullScreen(to: view)
        teamsView.tableView.registerCell(TeamCell.self)
        teamsView.tableView.delegate = self
        teamsView.tableView.dataSource = self
    }
    
    fileprivate func fetchTeams() {
        
    }
}

// MARK: - ControllerType Methods
extension TeamsController: ControllerType {
    
    static func create() -> UIViewController {
        let vc = TeamsController()
        return vc
    }
}

// MARK: - UITableViewDelegate Methods
extension TeamsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
}

// MARK: - UITableViewDataSource Methods
extension TeamsController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as TeamCell
        cell.team.text = "New York Yankees"
        return cell
    }
}
