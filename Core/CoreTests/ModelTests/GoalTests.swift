//
//  GoalTests.swift
//  CoreTests
//
//  Created by Ville Välimaa on 2020/6/9.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import XCTest

class GoalTests: XCTestCase {

    func testGoalNormalRunning() throws {
        let goal = Goal(id: "1000", title: "test_title", description: "desc", type: "running_distance", goal: 5000, trophy: "Medal", points: 1000)
        XCTAssertEqual(goal.id, "1000")
        XCTAssertEqual(goal.title, "test_title")
        XCTAssertEqual(goal.description, "desc")
        XCTAssertEqual(goal.type, .runningDistance)
        XCTAssertEqual(goal.goal, 5000)
        XCTAssertEqual(goal.reward.trophy, "Medal")
        XCTAssertEqual(goal.reward.points, 1000)
    }

    func testGoalNormalWalking() throws {
        let goal = Goal(id: "1000", title: "test_title", description: "desc", type: "walking_distance", goal: 5000, trophy: "Medal", points: 1000)
        XCTAssertEqual(goal.id, "1000")
        XCTAssertEqual(goal.title, "test_title")
        XCTAssertEqual(goal.description, "desc")
        XCTAssertEqual(goal.type, .walkingDistance)
        XCTAssertEqual(goal.goal, 5000)
        XCTAssertEqual(goal.reward.trophy, "Medal")
        XCTAssertEqual(goal.reward.points, 1000)
    }

    func testGoalNormalStep() throws {
        let goal = Goal(id: "1000", title: "test_title", description: "desc", type: "step", goal: 5000, trophy: "Medal", points: 1000)
        XCTAssertEqual(goal.id, "1000")
        XCTAssertEqual(goal.title, "test_title")
        XCTAssertEqual(goal.description, "desc")
        XCTAssertEqual(goal.type, .step)
        XCTAssertEqual(goal.goal, 5000)
        XCTAssertEqual(goal.reward.trophy, "Medal")
        XCTAssertEqual(goal.reward.points, 1000)
    }

    func testGoalNormalDefaultType() throws {
        let goal = Goal(id: "1000", title: "test_title", description: "desc", type: "invalid_type", goal: 5000, trophy: "Medal", points: 1000)
        XCTAssertEqual(goal.id, "1000")
        XCTAssertEqual(goal.title, "test_title")
        XCTAssertEqual(goal.description, "desc")
        XCTAssertEqual(goal.type, .step)
        XCTAssertEqual(goal.goal, 5000)
        XCTAssertEqual(goal.reward.trophy, "Medal")
        XCTAssertEqual(goal.reward.points, 1000)
    }

    func testGoals() throws {
        let goal1 = Goal(id: "1000", title: "test_title", description: "desc", type: "invalid_type", goal: 5000, trophy: "Medal", points: 1000)
        let goal2 = Goal(id: "1001", title: "test_title", description: "desc", type: "invalid_type", goal: 5000, trophy: "Medal", points: 1000)
        let goals = Goals(items: [goal1, goal2])
        XCTAssertEqual(goals.items[0].id, "1000")
        XCTAssertEqual(goals.items[1].id, "1001")
    }

    func testAsGoal() throws {
        let goal = Goal(id: "1000", title: "test_title", description: "desc", type: "invalid_type", goal: 5000, trophy: "Medal", points: 1000)
        let goal2 = goal.asGoal()
        XCTAssertEqual(goal.id, goal2.id)
        XCTAssertEqual(goal.title, goal2.title)
        XCTAssertEqual(goal.description, goal2.description)
        XCTAssertEqual(goal.type, goal2.type)
        XCTAssertEqual(goal.goal, goal2.goal)
        XCTAssertEqual(goal.reward.trophy, goal2.reward.trophy)
        XCTAssertEqual(goal.reward.points, goal2.reward.points)
    }

    func testReward() {
        let reward = Reward(trophy: "Medal", points: 1000)
        XCTAssertEqual(reward.trophy, "Medal")
        XCTAssertEqual(reward.points, 1000)
    }
}
