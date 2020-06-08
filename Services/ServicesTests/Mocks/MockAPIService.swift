//
//  MockAPIService.swift
//  ServicesTests
//
//  Created by Ville Välimaa on 2020/6/8.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import RxSwift
import Networking
import Core

class MockAPIService: APIServiceProtocol {
    private var failing = false

    init(failing: Bool) {
        self.failing = failing
    }

    func getGoals() -> Observable<[Goalable]> {
        return Observable.create { [unowned self] observer in
            if self.failing {
                observer.onError(APIError.unknown(400))
            } else {
                observer.onNext([
                    Goal(id: "1001", title: "GoalFromRemote", description: "Run", type: "steps", goal: 500, trophy: "trophy", points: 100),
                    Goal(id: "1002", title: "GoalFromRemote", description: "Run", type: "steps", goal: 500, trophy: "trophy", points: 100),
                    Goal(id: "1003", title: "GoalFromRemote", description: "Run", type: "steps", goal: 500, trophy: "trophy", points: 100)
                ])
            }
            return Disposables.create()
        }
    }
}
