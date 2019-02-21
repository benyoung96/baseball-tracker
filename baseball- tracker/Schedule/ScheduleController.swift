//
//  ViewController.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/20/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import UIKit

class ScheduleController: UITableViewController {
    
    private var scheduleItems: [ScheduleItem] = []
    
    private var networkManager: ScheduleNetworkManager
    
    init(_ networkManager: ScheduleNetworkManager) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        getSchedule()
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
    
    fileprivate func getSchedule() {
        networkManager.getSchedule("yankees") { (schedule, error) in
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

// MARK: - ControllerType Methods
extension ScheduleController: ControllerType {
    
    static func create() -> UIViewController {
        let networkManager = ScheduleNetworkManager()
        let vc = ScheduleController(networkManager)
        return vc
    }
}

// MARK: - UITableViewDelegate Methods
extension ScheduleController {
    
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
