//
//  EndPoint.swift
//  Networking
//
//  Created by Ville Välimaa on 2020/6/6.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation

/// Endpoint: protocol for endpoints to the APIClient
///
public protocol EndPoint {
    var base: String { get }
    var path: String { get }
    var query: String { get }
    var parameters: [String: Any]? { get }
}

extension EndPoint {
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.query = query
        return components
    }

    var url: URL {
        return urlComponents.url!
    }

    var request: URLRequest {
        return URLRequest(url: url)
    }
}
