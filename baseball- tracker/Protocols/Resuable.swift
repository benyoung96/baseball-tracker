//
//  Resuable.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/21/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import UIKit

protocol Reusable {}

extension Reusable where Self: UITableViewCell {
    
    static var reuseId: String {
        return String(describing: self)
    }
}
