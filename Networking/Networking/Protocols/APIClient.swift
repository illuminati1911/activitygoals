//
//  APIClient.swift
//  Networking
//
//  Created by Ville Välimaa on 2020/6/6.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation

/// APIMethod: Valid HTTP types for APIClient
///
public enum APIMethod: String {
    case GET
    case PATCH
    case POST
    case PUT
    case DELETE
}

/// APIError: Error type for APIClient
///
public enum APIError: Error {
    case requestFailure
    case invalidPayload
    case responseFailure(_ responseCode: Int)
    case invalidData(_ responseCode: Int)
    case decodingFailure(_ responseCode: Int)
    case unknown(_ responseCode: Int)

    var localizedDescription: String {
        switch self {
        case .requestFailure:
            return "Request failure"
        case .invalidPayload:
            return "Could not serialize payload"
        case .responseFailure:
            return "Response failure"
        case .invalidData:
            return "Could not receive valid payload in response"
        case .decodingFailure:
            return "Could not decode JSON response"
        case .unknown:
            return "Unknown error"

        }
    }
}

/// APIClient: Generic API client protocol
///
public protocol APIClient: class {
    var session: URLSession { get }
}

/// APIClient: Make request to any endpoint which is provided by EndPoint protocol conforming type
/// and match that with any Decodable conforming type.
///
extension APIClient {
    public func fetch<T: EndPoint, U: Decodable>(method: APIMethod, endPoint: T, decodingType: U.Type, _ completion: @escaping (Result<U, APIError>) -> Void) {
        var request = URLRequest(url: endPoint.url)
        request.httpMethod = method.rawValue

        // Manage JSON payload
        //
        if let params = endPoint.parameters, [APIMethod.POST, APIMethod.PATCH, APIMethod.PUT].contains(method) {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params as Any, options: .prettyPrinted)
            } catch {
                completion(.failure(APIError.invalidPayload))
            }
        }

        // API task
        //
        let task = self.session.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(APIError.requestFailure))
                return
            }
            guard let data = data else {
                completion(.failure(APIError.invalidData(response.statusCode)))
                return
            }
            guard (200 ... 299) ~= response.statusCode, error == nil else {
                completion(.failure(APIError.responseFailure(response.statusCode)))
                return
            }

            do {
                let jsonData = try JSONDecoder().decode(decodingType, from: data)
                completion(.success(jsonData))
            } catch {
                completion(.failure(APIError.decodingFailure(response.statusCode)))
                return
            }
        }
        task.resume()
    }
}
