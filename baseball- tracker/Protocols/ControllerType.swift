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
    
    /// Factory function for view controller instatiation
    ///
    /// - Parameter container: Persistent Core Data Container
    /// - Returns: View controller of concrete type
    @objc optional static func create(_ container: NSPersistentContainer) -> UIViewController
    
    @objc optional static func create() -> UIViewController
}
