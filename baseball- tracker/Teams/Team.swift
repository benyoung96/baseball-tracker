//
//  Team.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/22/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import Foundation
import CoreData

final class Team: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case location
        case ballpark
        case league
    }
    
    @NSManaged fileprivate(set) var name: String
    @NSManaged fileprivate(set) var location: String
    @NSManaged fileprivate(set) var ballpark: String
    @NSManaged fileprivate(set) var league: String
    
    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManageObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManageObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Team", in: managedObjectContext) else {
            fatalError("Failed to decode Team")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        location = try container.decode(String.self, forKey: .location)
        ballpark = try container.decode(String.self, forKey: .ballpark)
        league = try container.decode(String.self, forKey: .league)
    }
    
    // MARK - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(location, forKey: .location)
        try container.encode(ballpark, forKey: .ballpark)
        try container.encode(league, forKey: .league)
    }
}

extension Team {
    
    func prepareForView() -> String {
        return "\(location) \(name)"
    }
}

extension Team: Managed {
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(league), ascending: true), NSSortDescriptor(key: #keyPath(location), ascending: true)]
    }
}
