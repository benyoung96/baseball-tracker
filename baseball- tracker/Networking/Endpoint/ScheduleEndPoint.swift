//
//  ScheduleEndPoint.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/20/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import Foundation

public enum ScheduleEndPoint {
    case getGames(team: String)
}

extension ScheduleEndPoint: EndPointType {
    
    var baseUrl: URL {
        return URL(string: "http://localhost:8080/")!
    }
    
    var path: String {
        switch self {
        case .getGames(let team):
            return "api/\(team)/schedule"
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
