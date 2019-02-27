//
//  ViewController.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/20/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import UIKit
import CoreData

class ScheduleController: UITableViewController {
    weak var coordinator: MainCoordiantor?
    
    private let scheduleView = ScheduleView()
    private var scheduleItems: [ScheduleItem] = []
    
    private var networkManager: ScheduleNetworkManager
    private let container: NSPersistentContainer
    
    init(_ networkManager: ScheduleNetworkManager, _ container: NSPersistentContainer) {
        self.networkManager = networkManager
        self.container = container
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkForFavoriteTeam()
    }
}

// MARK: - Private Methods
extension ScheduleController {
    
    fileprivate func setupTableView() {
        tableView.registerCell(ScheduleCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    fileprivate func setupViews() {
        view.addSubview(scheduleView)
        scheduleView.safeAreaFullScreen(to: view)
        scheduleView.isHidden = true
    }
    
    fileprivate func checkForFavoriteTeam() {
        print(UserConfig().getFavoriteTeam() as Any)
        if let team = UserConfig().getFavoriteTeam() {
            getSchedule()
            scheduleView.isHidden = true
            navigationItem.title = team
        } else {
            scheduleView.isHidden = false
        }
    }
    
    fileprivate func getSchedule() {
        let team = UserConfig().getFavoriteTeam() ?? ""
        networkManager.getSchedule(team) { (schedule, error) in
            if error != nil {
                print(error as Any)
            }
            if let schedule = schedule {
                self.scheduleItems = schedule
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

// MARK: - Target Actions
extension ScheduleController {
    
    @objc func selectFavoriteTeam(_ sender: UIButton) {
        coordinator?.showSetup()
    }
}

// MARK: - ControllerType Methods
extension ScheduleController: ControllerType {
    
    static func create(_ container: NSPersistentContainer) -> UIViewController {
        let networkManager = ScheduleNetworkManager()
        let vc = ScheduleController(networkManager, container)
        return vc
    }
}

// MARK: - UITableViewDelegate Methods
extension ScheduleController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped a game")
    }
}

// MARK: - UITableViewDataSource Methods
extension ScheduleController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ScheduleCell
        let info = scheduleItems[indexPath.item].prepareData()
        
        cell.title.text = info.0
        cell.date.text = info.1
        
        return cell
    }
}
