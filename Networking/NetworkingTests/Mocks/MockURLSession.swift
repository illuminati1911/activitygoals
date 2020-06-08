//
//  MockURLSession.swift
//  NetworkingTests
//
//  Created by Ville Välimaa on 2020/6/8.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import Core

class MockURLSession: URLSessionProtocol {
    var goals: [Goalable] = []
    var statusCode = 200

    init(goals: [Goalable], statusCode: Int) {
        self.goals = goals
        self.statusCode = statusCode
    }

    func dataTaskProtocol(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return MockURLSessionDataTask(goals: goals, statusCode: statusCode, handler: completionHandler)
    }
}
