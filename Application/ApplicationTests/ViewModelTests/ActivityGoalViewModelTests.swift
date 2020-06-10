//
//  ActivityGoalViewModelTests.swift
//  ApplicationTests
//
//  Created by Ville Välimaa on 2020/6/10.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import XCTest
import Core

class ActivityGoalViewModelTests: XCTestCase {

    func testActivityGoalViewModelRemainingRunning() throws {
        let agvm = ActivityGoalViewModel(
            goalable: Goal(id: "1000",
                           title: "test_title",
                           description: "desc",
                           type: "running_distance",
                           goal: 5000,
                           trophy: "Medal",
                           points: 1000),
            activity: Activity(steps: 5000, distance: 2000))
        XCTAssertEqual(agvm.titleText, "test_title")
        XCTAssertEqual(agvm.displayDailyActivityText, "Your daily activity: 5000 steps, 2000 meters")
        XCTAssertEqual(agvm.goalTargetText, "Target: 5000 meters")
        XCTAssertEqual(agvm.statusText, "Still 3000 meters left")
        XCTAssertEqual(agvm.typeImage, Images.runningIcon)
    }

    func testActivityGoalViewModelRemainingWalking() throws {
        let agvm = ActivityGoalViewModel(
            goalable: Goal(id: "1000",
                           title: "test_title",
                           description: "desc",
                           type: "walking_distance",
                           goal: 5000,
                           trophy: "Medal",
                           points: 1000),
            activity: Activity(steps: 5000, distance: 2000))
        XCTAssertEqual(agvm.titleText, "test_title")
        XCTAssertEqual(agvm.displayDailyActivityText, "Your daily activity: 5000 steps, 2000 meters")
        XCTAssertEqual(agvm.goalTargetText, "Target: 5000 meters")
        XCTAssertEqual(agvm.statusText, "Still 3000 meters left")
        XCTAssertEqual(agvm.typeImage, Images.runningIcon)
    }

    func testActivityGoalViewModelRemainingSteps() throws {
        let agvm = ActivityGoalViewModel(
            goalable: Goal(id: "1000",
                           title: "test_title",
                           description: "desc",
                           type: "steps",
                           goal: 5000,
                           trophy: "Medal",
                           points: 1000),
            activity: Activity(steps: 4000, distance: 2000))
        XCTAssertEqual(agvm.titleText, "test_title")
        XCTAssertEqual(agvm.displayDailyActivityText, "Your daily activity: 4000 steps, 2000 meters")
        XCTAssertEqual(agvm.goalTargetText, "Target: 5000 steps")
        XCTAssertEqual(agvm.statusText, "Still 1000 steps left")
        XCTAssertEqual(agvm.typeImage, Images.stepIcon)
    }

    func testActivityGoalViewModelCompletedSteps() throws {
        let agvm = ActivityGoalViewModel(
            goalable: Goal(id: "1000",
                           title: "test_title",
                           description: "desc",
                           type: "steps",
                           goal: 5000,
                           trophy: "Medal",
                           points: 1000),
            activity: Activity(steps: 6000, distance: 2000))
        XCTAssertEqual(agvm.titleText, "test_title")
        XCTAssertEqual(agvm.displayDailyActivityText, "Your daily activity: 6000 steps, 2000 meters")
        XCTAssertEqual(agvm.goalTargetText, "Target: 5000 steps")
        XCTAssertEqual(agvm.statusText, "Goal completed!")
        XCTAssertEqual(agvm.typeImage, Images.stepIcon)
    }

    func testActivityGoalViewModelCompletedRunning() throws {
        let agvm = ActivityGoalViewModel(
            goalable: Goal(id: "1000",
                           title: "test_title",
                           description: "desc",
                           type: "running_distance",
                           goal: 5000,
                           trophy: "Medal",
                           points: 1000),
            activity: Activity(steps: 6000, distance: 10000))
        XCTAssertEqual(agvm.titleText, "test_title")
        XCTAssertEqual(agvm.displayDailyActivityText, "Your daily activity: 6000 steps, 10000 meters")
        XCTAssertEqual(agvm.goalTargetText, "Target: 5000 meters")
        XCTAssertEqual(agvm.statusText, "Goal completed!")
        XCTAssertEqual(agvm.typeImage, Images.runningIcon)
    }

    func testActivityGoalViewModelCompletedWalking() throws {
        let agvm = ActivityGoalViewModel(
            goalable: Goal(id: "1000",
                           title: "test_title",
                           description: "desc",
                           type: "walking_distance",
                           goal: 5000,
                           trophy: "Medal",
                           points: 1000),
            activity: Activity(steps: 6000, distance: 10000))
        XCTAssertEqual(agvm.titleText, "test_title")
        XCTAssertEqual(agvm.displayDailyActivityText, "Your daily activity: 6000 steps, 10000 meters")
        XCTAssertEqual(agvm.goalTargetText, "Target: 5000 meters")
        XCTAssertEqual(agvm.statusText, "Goal completed!")
        XCTAssertEqual(agvm.typeImage, Images.runningIcon)
    }
}
