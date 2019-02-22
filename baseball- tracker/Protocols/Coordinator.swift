//
//  Coordinator.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/20/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import UIKit
import CoreData

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    var container: NSPersistentContainer { get set }
    
    func start()
}
