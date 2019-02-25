//
//  TeamsNetworkManager.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/24/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import Foundation
import CoreData

struct TeamsNetworkManager {
    var container: NSPersistentContainer?
    private let router = Router<TeamsEndPoint>()
    
    func getTeams(completion: @escaping (_ teams: [Team]?, _ error: String?) -> Void) {
        router.request(.getTeams()) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = NetworkManager.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let data = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    
                    do {
                        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                            fatalError("Failed to retrieve context")
                        }
                        
                        let managedObjectContext = self.container?.viewContext
                        let decoder = JSONDecoder()
                        decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
                        let apiReponse = try decoder.decode([Team].self, from: data)
//                        try self.container?.viewContext.save()
                        completion(apiReponse, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
}
