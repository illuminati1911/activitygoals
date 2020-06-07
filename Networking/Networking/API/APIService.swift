//
//  APIService.swift
//  Networking
//
//  Created by Ville Välimaa on 2020/6/7.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import Core

public class APIService: APIClient, APIServiceProtocol {
    public let session: URLSession = URLSession(configuration: .default)

    public init() {}

    public func getGoals(_ completion: @escaping (Result<[Goalable], Error>) -> ()) {
        fetch(method: .GET, endPoint: GoalsEndpoint(), decodingType: Goals.self) {
            switch $0 {
                case .success(let goals):
                    // Pull goals out of the items container
                    //
                    completion(.success(goals.items))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
