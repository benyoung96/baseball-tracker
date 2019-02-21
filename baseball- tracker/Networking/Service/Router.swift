//
//  Router.swift
//  NKTR
//
//  Created by Ben Young on 2/12/19.
//  Copyright © 2019 Engaged Networks. All rights reserved.
//

import Foundation

class Router<EndPoint: EndPointType>: NetworkRouter {
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                completion(data, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
        
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseUrl.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestUrl(let urlParameters, _):
                try self.configureParamters(json: nil, urlParameters: urlParameters, request: &request)
                break
            case .requestJson(let json, _):
                request.addValue("Bearer \(route.token)", forHTTPHeaderField: "Authorization")
                try self.configureParamters(json: json, urlParameters: nil, request: &request)
                break
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParamters(json: Data?, urlParameters: URLParameters?, request: inout URLRequest) throws {
        do {
            if let urlParameters = urlParameters {
                try ParameterEncoding.encode(urlRequest: &request, with: urlParameters)
            }
            if let json = json {
                try ParameterEncoding.encode(urlRequest: &request, with: json)
            }
        } catch {
            throw error
        }
    }
}
