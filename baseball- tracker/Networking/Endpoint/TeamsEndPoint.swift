//
//  TeamsEndPoint.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/24/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import Foundation

public enum TeamsEndPoint {
    case getTeams()
}

extension TeamsEndPoint: EndPointType {
    
    var baseUrl: URL {
        return URL(string: "http://localhost:8080/")!
    }
    
    var path: String {
        return "api/teams"
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
