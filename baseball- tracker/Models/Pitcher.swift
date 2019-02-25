//
//  Pitcher.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/25/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import Foundation
import CoreData

final class Pitcher: NSManagedObject {
    @NSManaged fileprivate(set) var firstName: String
    @NSManaged fileprivate(set) var lastName: String
    @NSManaged fileprivate(set) var number: Int16
    @NSManaged fileprivate(set) var rotationPosition: Int16
    @NSManaged fileprivate(set) var team: Team
    
    static func insert(into context: NSManagedObjectContext, player: Player, team: Team, rotationPosition: Int16) -> Pitcher {
        let pitcher: Pitcher = context.insertObject()
        pitcher.firstName = player.firstName
        pitcher.lastName = player.firstName
        pitcher.number = player.number
        pitcher.rotationPosition = rotationPosition
        pitcher.team = team
        return pitcher
    }
}

extension Pitcher: Managed {
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(firstName), ascending: true)]
    }
}
