//
//  ProvidersTests.swift
//  ServicesTests
//
//  Created by Ville Välimaa on 2020/6/8.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import XCTest
import RxSwift
import Networking
import LocalStorage
import Core

class ProvidersTests: XCTestCase {
    let disposeBag = DisposeBag()

    func testDefaultRemoteLocalProvider() throws {
        let expectation = XCTestExpectation(description: "Fetch goals from the service")
        var fetchedGoals: [Goalable]?

        let remoteWithLocal = RemoteWithLocalDataProvider(
            remote: MockAPIService(failing: false),
            local: MockLocalStorage(failing: false))
        remoteWithLocal.getGoals().subscribe(onNext: { goals in
            fetchedGoals = goals
            expectation.fulfill()
        }).disposed(by: disposeBag)

        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(fetchedGoals!.count, 3)
        XCTAssertEqual(fetchedGoals![0].asGoal().title, "GoalFromRemote")
        XCTAssertEqual(fetchedGoals![1].asGoal().title, "GoalFromRemote")
        XCTAssertEqual(fetchedGoals![2].asGoal().title, "GoalFromRemote")
    }

    func testDefaultRemoteLocalProviderWithFailingLocal() throws {
        let expectation = XCTestExpectation(description: "Fetch goals from the provider")
        var fetchedGoals: [Goalable]?

        let remoteWithLocal = RemoteWithLocalDataProvider(
            remote: MockAPIService(failing: false),
            local: MockLocalStorage(failing: true))
        remoteWithLocal.getGoals().subscribe(onNext: { goals in
            fetchedGoals = goals
            expectation.fulfill()
        }).disposed(by: disposeBag)

        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(fetchedGoals!.count, 3)
        XCTAssertEqual(fetchedGoals![0].asGoal().title, "GoalFromRemote")
        XCTAssertEqual(fetchedGoals![1].asGoal().title, "GoalFromRemote")
        XCTAssertEqual(fetchedGoals![2].asGoal().title, "GoalFromRemote")
    }

    func testDefaultRemoteLocalProviderWithFailingRemote() throws {
        let expectation = XCTestExpectation(description: "Fetch goals from the provider")
        var fetchedGoals: [Goalable]?

        let remoteWithLocal = RemoteWithLocalDataProvider(
            remote: MockAPIService(failing: true),
            local: MockLocalStorage(failing: false))
        remoteWithLocal.getGoals().subscribe(onNext: { goals in
            fetchedGoals = goals
            expectation.fulfill()
        }).disposed(by: disposeBag)

        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(fetchedGoals!.count, 3)
        XCTAssertEqual(fetchedGoals![0].asGoal().title, "GoalFromLocal")
        XCTAssertEqual(fetchedGoals![1].asGoal().title, "GoalFromLocal")
        XCTAssertEqual(fetchedGoals![2].asGoal().title, "GoalFromLocal")
    }

    func testDefaultRemoteLocalProviderWithBothFailing() throws {
        let expectation = XCTestExpectation(description: "Fetch error from the provider")
        var fetchedError: Error?

        let remoteWithLocal = RemoteWithLocalDataProvider(
            remote: MockAPIService(failing: true),
            local: MockLocalStorage(failing: true))
        remoteWithLocal.getGoals().subscribe(onError: { error in
            expectation.fulfill()
            fetchedError = error
        }).disposed(by: disposeBag)

        wait(for: [expectation], timeout: 10.0)

        let isProperError = { () -> Bool in
            if case CoreDataProviderError.unknown = fetchedError! {
                return true
            }
            return false
        }
        XCTAssertTrue(isProperError())
    }

    func testLocalCache() throws {
        let expectation = XCTestExpectation(description: "Verify that goals get cached")
        let local = MockLocalStorage(failing: false, expectation: expectation)

        let remoteWithLocal = RemoteWithLocalDataProvider(
            remote: MockAPIService(failing: false),
            local: local)
        remoteWithLocal
            .getGoals()
            .subscribe()
            .disposed(by: disposeBag)

        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(local.goalDB.count, 3)
        XCTAssertEqual(local.goalDB[0].asGoal().title, "GoalFromRemote")
        XCTAssertEqual(local.goalDB[1].asGoal().title, "GoalFromRemote")
        XCTAssertEqual(local.goalDB[2].asGoal().title, "GoalFromRemote")
    }
}
