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
    
    fileprivate static func insert(into context: NSManagedObjectContext, player: Player, team: Team, rotationPosition: Int16) -> Pitcher {
        let pitcher: Pitcher = context.insertObject()
        pitcher.firstName = player.firstName
        pitcher.lastName = player.firstName
        pitcher.number = player.number
        pitcher.rotationPosition = rotationPosition
        pitcher.team = team
        return pitcher
    }
    
    static func saveRotation(into context: NSManagedObjectContext, pitchers: [Player], selected: inout [Player], team: Team) {
        for player in pitchers {
            let contains = selected.contains { (selectedPitcher) -> Bool in
                if selectedPitcher.number == player.number {
                    return true
                } else {
                    return false
                }
            }
            if !contains {
                selected.append(player)
            }
        }
        
        for (index, player) in selected.enumerated() {
            if index <= 4 {
                _ = Pitcher.insert(into: context, player: player, team: team, rotationPosition: Int16(index + 1))
            } else {
                _ = Pitcher.insert(into: context, player: player, team: team, rotationPosition: 0)
            }
        }
    }
}

extension Pitcher: Managed {
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(firstName), ascending: true)]
    }
}
