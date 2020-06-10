//
//  MockLocalStorage.swift
//  ServicesTests
//
//  Created by Ville Välimaa on 2020/6/8.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import LocalStorage
import Core
import XCTest
import RxSwift

class MockLocalStorage: LocalStorageProtocol {
    private var failing = false
    private var expectation: XCTestExpectation?

    var goalDB: [Goalable] = []

    init(failing: Bool, expectation: XCTestExpectation? = nil) {
        self.failing = failing
        self.expectation = expectation
    }

    func createGoals(goalables: [Goalable]) -> Observable<[Goalable]> {
        goalDB.append(contentsOf: goalables)
        expectation?.fulfill()
        return Observable.from(optional: [
            Goal(id: "1001", title: "GoalFromLocal", description: "Run", type: "steps", goal: 500, trophy: "trophy", points: 100),
            Goal(id: "1002", title: "GoalFromLocal", description: "Run", type: "steps", goal: 500, trophy: "trophy", points: 100),
            Goal(id: "1003", title: "GoalFromLocal", description: "Run", type: "steps", goal: 500, trophy: "trophy", points: 100)
        ])
    }

    func fetchGoals() -> Observable<[Goalable]> {
        return Observable.create { [unowned self] observer in
            if self.failing {
                observer.onError(CoreDataProviderError.unknown)
            } else {
                observer.onNext([
                    Goal(id: "1001", title: "GoalFromLocal", description: "Run", type: "steps", goal: 500, trophy: "trophy", points: 100),
                    Goal(id: "1002", title: "GoalFromLocal", description: "Run", type: "steps", goal: 500, trophy: "trophy", points: 100),
                    Goal(id: "1003", title: "GoalFromLocal", description: "Run", type: "steps", goal: 500, trophy: "trophy", points: 100)
                ])
            }
            return Disposables.create()
        }
    }

    func deleteGoals() -> Observable<Void> {
        goalDB = []
        return Observable.from(optional: ())
    }
}
