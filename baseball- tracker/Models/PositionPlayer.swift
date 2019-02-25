//
//  PositionPlayer.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/25/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import Foundation
import CoreData

final class PositionPlayer: NSManagedObject {
    @NSManaged fileprivate(set) var firstName: String
    @NSManaged fileprivate(set) var lastName: String
    @NSManaged fileprivate(set) var lineUpPosition: Int16
    @NSManaged fileprivate(set) var number: Int16
    @NSManaged fileprivate(set) var position: String
    @NSManaged fileprivate(set) var team: Team
    
    static func insert(into context: NSManagedObjectContext, player: Player, team: Team, lineUpPosition: Int16) -> PositionPlayer {
        let positionPlayer: PositionPlayer = context.insertObject()
        positionPlayer.firstName = player.firstName
        positionPlayer.lastName = player.lastName
        positionPlayer.number = player.number
        positionPlayer.position = player.position
        positionPlayer.lineUpPosition = lineUpPosition
        positionPlayer.team = team
        return positionPlayer
    }
}

extension PositionPlayer: Managed {
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(firstName), ascending: true)]
    }
}
