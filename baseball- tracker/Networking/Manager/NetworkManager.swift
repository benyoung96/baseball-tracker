//
//  UserNetworkManager.swift
//  NKTR
//
//  Created by Ben Young on 2/12/19.
//  Copyright © 2019 Engaged Networks. All rights reserved.
//

import Foundation

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first"
    case badRequeset = "Bad request"
    case outDated = "The url requested is outdated"
    case failed = "Network request failed"
    case noData = "Response returned with no data to decode"
    case unableToDecode = "We could not decode that response"
}

enum Result<String> {
    case success
    case failure(String)
}

struct NetworkManager {
    
    static func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequeset.rawValue)
        case 600: return .failure(NetworkResponse.outDated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
