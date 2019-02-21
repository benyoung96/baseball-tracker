//
//  ScheduleNetworkManager.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/20/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import Foundation

struct ScheduleNetworkManager {
    private let router = Router<ScheduleEndPoint>()
    
    func getSchedule(_ team: String, completion: @escaping (_ games: [ScheduleItem]?, _ error: String?) -> Void) {
        router.request(.getGames(team: team)) { (data, response, error) in
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
                        let apiReponse = try JSONDecoder().decode([ScheduleItem].self, from: data)
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
