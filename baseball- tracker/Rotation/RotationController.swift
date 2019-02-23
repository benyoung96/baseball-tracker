//
//  RotationController.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/22/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import UIKit

class RotationController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
}

// MARK: - ControllerType Methods
extension RotationController: ControllerType {
    
    static func create() -> UIViewController {
        let vc = RotationController()
        return vc
    }
}
