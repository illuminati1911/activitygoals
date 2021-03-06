//
//  APIClient.swift
//  Networking
//
//  Created by Ville Välimaa on 2020/6/6.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import Core
import RxSwift

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
            return Localized.errorNetworkingRequest
        case .invalidPayload:
            return Localized.errorNetworkingPayload
        case .responseFailure:
            return Localized.errorNetworkingResponse
        case .invalidData:
            return Localized.errorNetworkingData
        case .decodingFailure:
            return Localized.errorNetworkingDecoding
        case .unknown:
            return Localized.errorUnknown

        }
    }
}

/// APIClient: Generic API client protocol
///
public protocol APIClient: class {
    var session: URLSessionProtocol { get }
}

/// APIClient: Make request to any endpoint which is provided by EndPoint protocol conforming type
/// and match that with any Decodable conforming type.
///
extension APIClient {
    public func fetch<T: EndPoint, U: Decodable>(method: APIMethod, endPoint: T, decodingType: U.Type) -> Observable<U> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                observer.onError(APIError.unknown(0))
                return Disposables.create()
            }
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
                    observer.onError(APIError.invalidPayload)
                    return Disposables.create()
                }
            }

            // API task
            //
            let task = self.session.dataTaskProtocol(with: request) { data, response, error in
                guard error == nil else {
                    observer.onError(APIError.requestFailure)
                    return
                }
                guard let response = response as? HTTPURLResponse else {
                    observer.onError(APIError.requestFailure)
                    return
                }
                guard let data = data else {
                    observer.onError(APIError.invalidData(response.statusCode))
                    return
                }
                guard (200 ... 299) ~= response.statusCode else {
                    observer.onError(APIError.responseFailure(response.statusCode))
                    return
                }

                do {
                    let jsonData = try JSONDecoder().decode(decodingType, from: data)
                    observer.onNext(jsonData)
                    observer.onCompleted()
                } catch {
                    observer.onError(APIError.decodingFailure(response.statusCode))
                    return
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
