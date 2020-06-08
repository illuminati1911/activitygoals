//
//  MockURLSessionDataTask.swift
//  NetworkingTests
//
//  Created by Ville Välimaa on 2020/6/8.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import Core

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    var handler: (Data?, URLResponse?, Error?) -> Void
    var goals: [Goalable] = []
    var statusCode = 200

    init(goals: [Goalable], statusCode: Int, handler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.handler = handler
        self.goals = goals
        self.statusCode = statusCode
    }

    func resume() {
        let response = HTTPURLResponse(url: URL(string: "http//www.example.com")!, statusCode: self.statusCode, httpVersion: "1.1", headerFields: nil)
        let goals = Goals(items: self.goals.map { $0.asGoal() })

        let encoder = JSONEncoder()
        guard let encoded = try? encoder.encode(goals) else {
            fatalError()
        }
        handler(encoded, response, nil)
    }
}
