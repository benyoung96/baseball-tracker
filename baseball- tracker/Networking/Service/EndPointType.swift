//
//  EndPointType.swift
//  NKTR
//
//  Created by Ben Young on 2/12/19.
//  Copyright © 2019 Engaged Networks. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseUrl: URL { get }
    var path: String { get }
    var httpMethod: HttpMethod { get }
    var task: HttpTask { get }
    var token: String { get }
}
