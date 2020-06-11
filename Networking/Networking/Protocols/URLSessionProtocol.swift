//
//  URLSessionProtocol.swift
//  Networking
//
//  Created by Ville Välimaa on 2020/6/11.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation

/// URLSessionProtocol: to loosely couple URLSession
///
public protocol URLSessionProtocol {
    func dataTaskProtocol(
      with request: URLRequest,
      completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    public func dataTaskProtocol(
      with request: URLRequest,
      completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler)
    }
}

/// URLSessionDataTaskProtocol: to loosely couple URLSessionDataTask
///
public protocol URLSessionDataTaskProtocol {
    func resume()
    func cancel()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
