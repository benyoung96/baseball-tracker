//
//  Team.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/22/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import Foundation
import CoreData

struct TeamJSON: Codable {
    var name: String
    let location: String
    let ballpark: String
    let league: String
    
    func prepareForView() -> String {
        return "\(location) \(name)"
    }
}

final class Team: NSManagedObject {
    @NSManaged fileprivate(set) var name: String
    @NSManaged fileprivate(set) var location: String
    @NSManaged fileprivate(set) var ballpark: String
    @NSManaged fileprivate(set) var league: String
    @NSManaged fileprivate(set) var positionPlayers: Set<PositionPlayer>
    @NSManaged fileprivate(set) var pitchers: Set<Pitcher>
    
    static func insert(into context: NSManagedObjectContext, teamJSON: TeamJSON) -> Team {
        let team: Team = context.insertObject()
        team.name = teamJSON.name
        team.location = teamJSON.location
        team.ballpark = teamJSON.ballpark
        team.league = teamJSON.league
        return team
    }
    
    static func getTeam(from context: NSManagedObjectContext, name: String, completion: @escaping ([Team]) -> Void) {
        let request = Team.sortedFetchRequest
        request.returnsObjectsAsFaults = false
        context.perform {
            completion(try! request.execute())
        }
    }
    
    static func deleteTeams(from context: NSManagedObjectContext) {
        let request = Team.sortedFetchRequest
        request.returnsObjectsAsFaults = false
        
        let objects = try! context.fetch(request)
        for object in objects {
            context.delete(object)
        }
        try! context.save()
    }
}

extension Team: Managed {
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(league), ascending: true), NSSortDescriptor(key: #keyPath(location), ascending: true)]
    }
    
    static var defaultPredicates: NSCompoundPredicate? {
        let team = UserConfig().getFavoriteTeam() ?? ""
        let predicate = NSPredicate(format: "name == %@", team)
        return NSCompoundPredicate(type: .and, subpredicates: [predicate])
    }
}
