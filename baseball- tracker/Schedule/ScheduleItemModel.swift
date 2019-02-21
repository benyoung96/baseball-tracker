//
//  GameMode.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/20/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import Foundation

struct ScheduleItem: Codable {
    let home: String
    let away: String
    let dayOfWeek: String
    let datetime: String
    
    func prepareData() -> (String, String) {
        let title = "\(away) at \(home)"
        let date = formatDate() ?? ""
        
        return (title, date)
    }
    
    private func formatDate() -> String? {
        let formatterGet = DateFormatter()
        formatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let formatterPrint = DateFormatter()
        formatterPrint.dateFormat = "E MMM dd, hh:mm a"
        
        if let date = formatterGet.date(from: datetime) {
            return formatterPrint.string(from: date)
        } else {
            print("There was an error decoding the string")
        }
        return nil
    }
}
