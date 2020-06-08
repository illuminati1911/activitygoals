//
//  HealthKitActivityProviderTests.swift
//  ServicesTests
//
//  Created by Ville Välimaa on 2020/6/8.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import XCTest
import RxSwift
import Core

class HealthKitActivityProviderTests: XCTestCase {
    let disposeBag = DisposeBag()

    func testHKActivityProviderSuccess() throws {
        let expectation = XCTestExpectation(description: "Fetch activity from provider")
        var fetchedActivity: Activity?
        let mockActivityService = MockActivityService(allowAccess: true)
        let hkProvider = HealthKitActivityProvider(activityService: mockActivityService)

        hkProvider.getActivity().subscribe(onNext: { activity in
            fetchedActivity = activity
            expectation.fulfill()
        }).disposed(by: disposeBag)

        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(fetchedActivity!.steps, 5000)
        XCTAssertEqual(fetchedActivity!.distance, 10000)
    }

    func testHKActivityProviderFailure() throws {
           let expectation = XCTestExpectation(description: "Get authorization error from provider")
           var fetchedError: Error?
           let mockActivityService = MockActivityService(allowAccess: false)
           let hkProvider = HealthKitActivityProvider(activityService: mockActivityService)

           hkProvider.getActivity().subscribe(onError: { error in
               fetchedError = error
               expectation.fulfill()
           }).disposed(by: disposeBag)

           wait(for: [expectation], timeout: 10.0)

        let isProperError = { (err: Error) -> Bool in
            if case HealthKitActivityProviderError.authorizationError = err {
                   return true
               }
               return false
           }
           XCTAssertTrue(isProperError(fetchedError!))
       }
}
