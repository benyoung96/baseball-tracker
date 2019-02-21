//
//  ParameterEncoding.swift
//  NKTR
//
//  Created by Ben Young on 2/12/19.
//  Copyright © 2019 Engaged Networks. All rights reserved.
//

import Foundation

public typealias URLParameters = [String: Any]

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: URLParameters) throws
    static func encode(urlRequest: inout URLRequest, with jsonData: Data) throws
}

public enum NetworkError: String, Error {
    case parametersNil = "Parameters are nil"
    case encodingFailed = "Parameter failed encoding"
    case missingUrl = "Url is nil"
}
