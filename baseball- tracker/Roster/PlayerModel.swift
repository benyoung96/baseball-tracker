//
//  PlayerModel.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/21/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import Foundation

struct Player: Codable {
    let number: Int
    let firstName: String
    let lastName: String
    let team: String
    
    func prepareData() -> String {
        return "\(firstName) \(lastName) - \(number)"
    }
}
