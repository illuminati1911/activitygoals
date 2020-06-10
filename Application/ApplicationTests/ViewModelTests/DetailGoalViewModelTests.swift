//
//  DetailGoalViewModelTests.swift
//  ApplicationTests
//
//  Created by Ville Välimaa on 2020/6/10.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import XCTest
import Core
import Services
import RxSwift

class DetailGoalViewModelTests: XCTestCase {

    func testFetchGoalsViewModels() throws {
        let disposeBag = DisposeBag()
        let expectation = XCTestExpectation(description: "Fetch ActivityGoalViewModel from the view model")
        var fetchedActivityGoalViewModel: ActivityGoalViewModel?
        let dgvm = DetailGoalViewModel(
            mainProvider: MockMainProvider(shouldFail: false),
            goalable: Goal(id: "1000",
                            title: "test_title",
                            description: "desc",
                            type: "step",
                            goal: 5000,
                            trophy: "Medal",
                            points: 1000))

        dgvm.fetchActivityGoalViewModels()
            .subscribe(onNext: { agvm in
                fetchedActivityGoalViewModel = agvm
                expectation.fulfill()
        }).disposed(by: disposeBag)

        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(fetchedActivityGoalViewModel?.titleText, "test_title")
    }

    func testFetchGoalsViewModelsFail() {
        let disposeBag = DisposeBag()
        let expectation = XCTestExpectation(description: "Fetch Error from the view model")
        var fetchedError: Error?
        let dgvm = DetailGoalViewModel(
            mainProvider: MockMainProvider(shouldFail: true),
            goalable: Goal(id: "1000",
                            title: "test_title",
                            description: "desc",
                            type: "step",
                            goal: 5000,
                            trophy: "Medal",
                            points: 1000))

        dgvm.fetchActivityGoalViewModels()
            .subscribe(onError: { error in
                fetchedError = error
                expectation.fulfill()
        }).disposed(by: disposeBag)

        wait(for: [expectation], timeout: 10.0)
        let isProperError = { (err: Error) -> Bool in
         if case HealthKitActivityProviderError.healthKitNotAvailableError = err {
                return true
            }
            return false
        }
        XCTAssertTrue(isProperError(fetchedError!))
    }
}
