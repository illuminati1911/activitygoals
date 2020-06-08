//
//  APIService.swift
//  Networking
//
//  Created by Ville Välimaa on 2020/6/7.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import RxSwift
import Core

public class APIService: APIClient, APIServiceProtocol {
    public var session: URLSessionProtocol

    public init(session: URLSessionProtocol = URLSession(configuration: .default)) {
        self.session = session
    }

    public func getGoals() -> Observable<[Goalable]> {
        return fetch(method: .GET, endPoint: GoalsEndpoint(), decodingType: Goals.self).map {
            $0.items
        }
    }
}
