//
//  GoalsListViewModelTests.swift
//  ApplicationTests
//
//  Created by Ville Välimaa on 2020/6/10.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import XCTest
import Core
import RxSwift
import Networking

class GoalsListViewModelTests: XCTestCase {

    func testFetchGoalsViewModels() throws {
        let disposeBag = DisposeBag()
        let expectation = XCTestExpectation(description: "Fetch goals from the view model")
        var fetchedGoalViewModels: [GoalViewModel]?
        let glvm = GoalsListViewModel(mainProvider: MockMainProvider(shouldFail: false))
        let obs = glvm.fetchGoalViewModels()
        obs.subscribe(onNext: { goalables in
            fetchedGoalViewModels = goalables
            expectation.fulfill()
        }).disposed(by: disposeBag)
        obs.connect()
            .disposed(by: disposeBag)

        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(fetchedGoalViewModels?.count, 1)
        XCTAssertEqual(fetchedGoalViewModels?[0].title, "test_title")
        XCTAssertEqual(fetchedGoalViewModels?[0].description, "desc")
    }

    func testFetchGoalsViewModelsFail() {
        let disposeBag = DisposeBag()
        let expectation = XCTestExpectation(description: "Fetch error from the view model")
        var fetchedError: Error?
        let glvm = GoalsListViewModel(mainProvider: MockMainProvider(shouldFail: true))
        let obs = glvm.fetchGoalViewModels()
        obs.subscribe(onError: { error in
            fetchedError = error
            expectation.fulfill()
        }).disposed(by: disposeBag)
        obs.connect()
            .disposed(by: disposeBag)

        wait(for: [expectation], timeout: 10.0)
        let isProperError = { (err: Error) -> Bool in
         if case APIError.requestFailure = err {
                return true
            }
            return false
        }
        XCTAssertTrue(isProperError(fetchedError!))
    }
}
