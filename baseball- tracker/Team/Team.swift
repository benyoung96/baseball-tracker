//
//  Team.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/22/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import Foundation
import CoreData

final class Team: NSManagedObject {
    @NSManaged fileprivate(set) var name: String
    @NSManaged fileprivate(set) var location: String
    @NSManaged fileprivate(set) var ballpark: String
    @NSManaged fileprivate(set) var league: String
}

extension Team: Managed {
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(league), ascending: true), NSSortDescriptor(key: #keyPath(location), ascending: true)]
    }
}
