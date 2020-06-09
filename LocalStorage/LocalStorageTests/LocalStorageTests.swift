//
//  LocalStorageTests.swift
//  LocalStorageTests
//
//  Created by Ville Välimaa on 2020/6/6.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import XCTest
import CoreData
import RxSwift
import Core
import LocalStorage

class LocalStorageTests: XCTestCase {
    let disposeBag = DisposeBag()

    func testExample() throws {
        /*let expectation = XCTestExpectation(description: "Fetch goals from the service")
        var fetchedGoals: [Goalable]?
        let mockContainer = MockPersistentContainer.getMockPersistentContainer()
        let coreDataProvider = CoreDataProvider(container: mockContainer)
        let goals = [
            Goal(id: "1001", title: "GoalFromLocal", description: "Run", type: "steps", goal: 500, trophy: "trophy", points: 100),
            Goal(id: "1002", title: "GoalFromLocal", description: "Run", type: "steps", goal: 500, trophy: "trophy", points: 100),
            Goal(id: "1003", title: "GoalFromLocal", description: "Run", type: "steps", goal: 500, trophy: "trophy", points: 100)
        ]

        coreDataProvider.createGoals(goalables: goals).subscribe(onNext: { goalables in
            fetchedGoals = goalables
            expectation.fulfill()
        }).disposed(by: disposeBag)

        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(fetchedGoals!.count, 3)*/

        //
        // TODO: Mock properly and fix
        //
    }
}
