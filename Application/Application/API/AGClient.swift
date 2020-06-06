//
//  AGClient.swift
//  Application
//
//  Created by Ville Välimaa on 2020/6/6.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import Networking
import RxSwift

class AGAPIClient: APIClient {
    var session: URLSession = URLSession(configuration: .default)

    func getDailyGoals() -> Observable<[Goal]> {
        return fetch(method: .GET, endPoint: GoalsEndpoint(), decodingType: Goals.self).map {
            return $0.items
        }
    }
}
