//
//  NetworkRouter.swift
//  NKTR
//
//  Created by Ben Young on 2/12/19.
//  Copyright © 2019 Engaged Networks. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}
