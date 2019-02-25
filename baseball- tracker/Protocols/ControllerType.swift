//
//  ControllerType.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/20/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import UIKit
import CoreData

@objc protocol ControllerType: class {
    
    @objc optional static func create(_ container: NSPersistentContainer) -> UIViewController
    
    @objc optional static func create() -> UIViewController
}
