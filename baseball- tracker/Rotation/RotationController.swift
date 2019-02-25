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
    
    private let container: NSPersistentContainer
    
    init(_ container: NSPersistentContainer) {
        self.container = container
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
}

// MARK: - ControllerType Methods
extension RotationController: ControllerType {
    
    static func create(_ container: NSPersistentContainer) -> UIViewController {
        let vc = RotationController(container)
        return vc
    }
}
