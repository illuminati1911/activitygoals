//
//  ExtensionsTests.swift
//  CoreTests
//
//  Created by Ville Välimaa on 2020/6/9.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import XCTest

class ExtensionsTests: XCTestCase {

    func testDoubleAsInt() throws {
        XCTAssertEqual(1.343.asInt(), 1)
        XCTAssertEqual(1.5.asInt(), 1)
        XCTAssertEqual(1.9.asInt(), 1)
        XCTAssertEqual(2.343.asInt(), 2)
        XCTAssertEqual(2.0.asInt(), 2)
        XCTAssertEqual(1.343.asInt(), 1)

        XCTAssertEqual(-1.343.asInt(), -1)
        XCTAssertEqual(-1.5.asInt(), -1)
        XCTAssertEqual(-1.9.asInt(), -1)
        XCTAssertEqual(-2.343.asInt(), -2)
        XCTAssertEqual(-2.0.asInt(), -2)
        XCTAssertEqual(-1.343.asInt(), -1)

        XCTAssertEqual(-12378432482.343.asInt(), -12378432482)
        XCTAssertEqual(12378432482.343.asInt(), 12378432482)
    }

    func testResult() {
        let res: Result<Int, Error> = Result.success(5)
        XCTAssertEqual(res.isSuccess, true)
        XCTAssertEqual(res.isError, false)

        let res2: Result<Int, Error> = Result.failure(NSError(domain: "domain", code: 1, userInfo: [:]))
        XCTAssertEqual(res2.isSuccess, false)
        XCTAssertEqual(res2.isError, true)
    }
}
