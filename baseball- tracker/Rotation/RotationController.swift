//
//  RotationController.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/22/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import UIKit
import CoreData

class RotationController: UIViewController {
    weak var coordinator: MainCoordiantor?
    
    private let rotationView = RotationView()
    
    private var pitchers: [Player] = []
    private var selectedPitchers: [Player] = []
    private var team: Team?
    
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
        setupViews()
        fetchPitchers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let name = UserConfig().getFavoriteTeam() ?? ""
        Team.getTeam(from: container.viewContext, name: name) { (team) in
            self.team = team.last
        }
    }
}

// MARK: - Private Methods
extension RotationController {
    
    fileprivate func setupViews() {
        view.backgroundColor = .main
        view.addSubview(rotationView)
        rotationView.safeAreaFullScreen(to: view)
        rotationView.tableView.registerCell(OnBoardingCell.self)
        rotationView.tableView.delegate = self
        rotationView.tableView.dataSource = self
    }
    
    fileprivate func fetchPitchers() {
        networkManager.getRoster("yankees") { (pitchers, error) in
            if error != nil {
                print(error as Any)
            }
            
            if let pitchers = pitchers {
                self.pitchers = pitchers.filter{ $0.position == "P" }
                DispatchQueue.main.async {
                    self.rotationView.tableView.reloadData()
                }
            }
        }
    }
    
    fileprivate func saveRotation() {
        for player in pitchers {
            let contains = selectedPitchers.contains { (selectedPitcher) -> Bool in
                if selectedPitcher.number == player.number {
                    return true
                } else {
                    return false
                }
            }
            if !contains {
                selectedPitchers.append(player)
            }
        }
        
        for (index, player) in selectedPitchers.enumerated() {
            if index <= 4 {
                _ = Pitcher.insert(into: container.viewContext, player: player, team: team!, rotationPosition: Int16(index + 1))
            } else {
                _ = Pitcher.insert(into: container.viewContext, player: player, team: team!, rotationPosition: 0)
            }
        }
    }
}

// MARK: - ControllerType Methods
extension RotationController: ControllerType {
    
    static func create(_ container: NSPersistentContainer) -> UIViewController {
        let networkManager = LineUpNetworkManager()
        let vc = RotationController(networkManager, container)
        return vc
    }
}

// MARK: - UITableViewDelegate Methods
extension RotationController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView.indexPathsForSelectedRows?.count ?? 0) < 6 {
            selectedPitchers.append(pitchers[indexPath.item])
            let cell: OnBoardingCell = tableView.cellForRow(at: indexPath) as! OnBoardingCell
            cell.slot.text = "\(selectedPitchers.count)"
        } else {
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedPitchers.remove(at: indexPath.item)
        let cell: OnBoardingCell = tableView.cellForRow(at: indexPath) as! OnBoardingCell
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
extension RotationController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return pitchers.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as OnBoardingCell
        cell.title.text = pitchers[indexPath.section].prepareData()
        return cell
    }
}
