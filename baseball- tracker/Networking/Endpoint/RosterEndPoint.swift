//
//  RosterEndPoint.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/21/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import Foundation

enum RosterEndPoint {
    case getRoster(_ team: String)
}

extension RosterEndPoint: EndPointType {
    
    var baseUrl: URL {
        return URL(string: "http://localhost:8080/")!
    }
    
    var path: String {
        switch self {
        case .getRoster(let team):
            return "api/\(team)/roster"
        }
    }
    
    var httpMethod: HttpMethod {
        return .get
    }
    
    var task: HttpTask {
        return .request
    }
    
    var token: String {
        return ""
    }
}
