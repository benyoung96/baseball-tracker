//
//  PlayerModel.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/21/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import Foundation

struct Player: Codable {
    let firstName: String
    let lastName: String
    let number: Int16
    let team: String
    let position: String
}

extension Player {
    
    func prepareData() -> String {
        return "\(firstName) \(lastName) - \(number)"
    }
}
