//
//  URLParameterEncoding.swift
//  NKTR
//
//  Created by Ben Young on 2/12/19.
//  Copyright © 2019 Engaged Networks. All rights reserved.
//

import Foundation

public struct ParameterEncoding: ParameterEncoder {
    
    public static func encode(urlRequest: inout URLRequest, with parameters: URLParameters) throws {
        guard let url = urlRequest.url else { throw NetworkError.missingUrl }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty{
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.addValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
    
    public static func encode(urlRequest: inout URLRequest, with jsonData: Data) throws {
        urlRequest.httpBody = jsonData
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
    }
}
