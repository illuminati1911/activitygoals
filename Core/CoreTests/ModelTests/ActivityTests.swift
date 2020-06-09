//
//  ActivityTests.swift
//  CoreTests
//
//  Created by Ville Välimaa on 2020/6/9.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import XCTest

class ActivityTests: XCTestCase {

    func testActivitySmall() throws {
        let acticity = Activity(steps: 49, distance: 53)
        XCTAssertEqual(acticity.distance, 53)
        XCTAssertEqual(acticity.steps, 49)
    }

    func testActivityNormal() throws {
        let acticity = Activity(steps: 8000, distance: 9000)
        XCTAssertEqual(acticity.distance, 9000)
        XCTAssertEqual(acticity.steps, 8000)
    }

    func testActivityLarge() throws {
        let acticity = Activity(steps: 800000, distance: 900000)
        XCTAssertEqual(acticity.distance, 900000)
        XCTAssertEqual(acticity.steps, 800000)
    }

    // HealthKit provides data as floats
    func testActivityDouble() throws {
        let acticity = Activity(steps: 100.5, distance: 900.23)
        XCTAssertEqual(acticity.distance, 900.23)
        XCTAssertEqual(acticity.steps, 100.5)
    }
}
