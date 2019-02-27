//
//  UserConfig.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/22/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import Foundation

struct UserConfig {
    
    private let firstBootKey = "com.benyoung.baseball-tracker.firstBoot"
    private let favoriteTeamKey = "com.benyoung.baseball-tracker.favoriteTeam"
}

// MARK: - First Boot Methods
extension UserConfig {
    
    func isFirstBoot() -> Bool {
        let firstBoot = UserDefaults.standard.bool(forKey: firstBootKey)
        return firstBoot
    }
    
    func setFirstBootStatus(_ firstBoot: Bool) {
        UserDefaults.standard.set(firstBoot, forKey: firstBootKey)
        UserDefaults.standard.synchronize()
    }
}

// MARK: - Favorite Team Methods
extension UserConfig {
    
    func getFavoriteTeam() -> String? {
        let team = UserDefaults.standard.string(forKey: favoriteTeamKey)
        return team
    }
    
    func saveFavoriteTeam(_ team: String?) {
        UserDefaults.standard.set(team, forKey: favoriteTeamKey)
        UserDefaults.standard.synchronize()
    }
}
