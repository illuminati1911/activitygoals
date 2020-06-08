//
//  APIServiceTests.swift
//  NetworkingTests
//
//  Created by Ville Välimaa on 2020/6/8.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import XCTest
import RxSwift
import Core

class APIServiceTests: XCTestCase {
    let disposeBag = DisposeBag()

    var responseGoal: Goal {
        return Goal(
            id: "1000",
            title: "Easy walk steps",
            description: "Walk 500 steps a day",
            type: "step",
            goal: 500,
            trophy: "bronze_medal",
            points: 6
        )
    }

    func testAPIServiceSuccess() throws {
        let expectation = XCTestExpectation(description: "Fetch goals from the service")
        var fetchedGoals: [Goalable]?
        let mockSession = MockURLSession(goals: [responseGoal], statusCode: 200)
        let service = APIService(session: mockSession)
        service.getGoals().subscribe(onNext: { goals in
            fetchedGoals = goals
            expectation.fulfill()
        }).disposed(by: disposeBag)

        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(fetchedGoals?.count, 1)
        XCTAssertEqual(fetchedGoals?[0].asGoal().title, "Easy walk steps")
        XCTAssertEqual(fetchedGoals?[0].asGoal().reward.points, 6)
    }

    func testAPIServiceFailure() throws {
        let expectation = XCTestExpectation(description: "Fetch goals from the service and fail")
        var fetchedError: Error?
        let mockSession = MockURLSession(goals: [], statusCode: 400)
        let service = APIService(session: mockSession)
        service.getGoals().subscribe(onError: { error in
            fetchedError = error
            expectation.fulfill()
        }).disposed(by: disposeBag)

        wait(for: [expectation], timeout: 10.0)

        let isProperError = { (err: Error) -> Bool in
         if case APIError.responseFailure(400) = err {
                return true
            }
            return false
        }
        XCTAssertTrue(isProperError(fetchedError!))
    }
}
