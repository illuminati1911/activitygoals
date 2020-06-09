//
//  UtilsTests.swift
//  CoreTests
//
//  Created by Ville Välimaa on 2020/6/9.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import XCTest
import UIKit

class UtilsTests: XCTestCase {

    func testWith() throws {
        let label = with(UILabel()) {
            $0.text = "Test"
            $0.textColor = .blue
            $0.textAlignment = .center
        }
        XCTAssertEqual(label.text, "Test")
        XCTAssertEqual(label.textColor, .blue)
        XCTAssertEqual(label.textAlignment, .center)
    }
}
