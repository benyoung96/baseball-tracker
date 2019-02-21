//
//  HttpTask.swift
//  NKTR
//
//  Created by Ben Young on 2/12/19.
//  Copyright © 2019 Engaged Networks. All rights reserved.
//

import Foundation

public typealias HttpHeaders = [String:String]

public enum HttpTask {
    
    case request
    
    case requestJson(jsonData: Data?, token: String)
    
    case requestUrl(urlParameters: URLParameters?, headers: HttpHeaders?)
}
