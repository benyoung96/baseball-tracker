//
//  PlayerModel.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/21/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import Foundation
import CoreData

final class Player: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case number
        case team
        case position
    }
    
    @NSManaged fileprivate(set) var firstName: String
    @NSManaged fileprivate(set) var lastName: String
    @NSManaged fileprivate(set) var number: Int16
    @NSManaged fileprivate(set) var team: String
    @NSManaged fileprivate(set) var position: String
    
    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManageObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManageObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Player", in: managedObjectContext) else {
                fatalError("Failed to decode Team")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        number = try container.decode(Int16.self, forKey: .number)
        team = try container.decode(String.self, forKey: .team)
        position = try container.decode(String.self, forKey: .position)
    }
    
    // MARK - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(number, forKey: .number)
        try container.encode(team, forKey: .team)
        try container.encode(position, forKey: .position)
    }
}

extension Player {
    
    func prepareData() -> String {
        return "\(firstName) \(lastName) - \(number)"
    }
}

extension Player: Managed {
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(team), ascending: true)]
    }
}
