//
//  GoalViewModelTests.swift
//  ApplicationTests
//
//  Created by Ville Välimaa on 2020/6/10.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import XCTest
import Core

class GoalViewModelTests: XCTestCase {

    func testGoalViewModelRunningIcon() throws {
        let gvm = GoalViewModel(goalable:
            Goal(id: "1000",
                 title: "test_title",
                 description: "desc",
                 type: "running_distance",
                 goal: 5000,
                 trophy: "Medal",
                 points: 1000)
        )
        XCTAssertEqual(gvm.rewardText, "Reward: 1000")
        XCTAssertEqual(gvm.title, "test_title")
        XCTAssertEqual(gvm.description, "desc")
        XCTAssertEqual(gvm.typeImage, Images.runningIcon)
    }

    func testGoalViewModelRunningIconWithWalking() throws {
           let gvm = GoalViewModel(goalable:
               Goal(id: "1000",
                    title: "test_title",
                    description: "desc",
                    type: "walking_distance",
                    goal: 5000,
                    trophy: "Medal",
                    points: 1000)
           )
           XCTAssertEqual(gvm.rewardText, "Reward: 1000")
           XCTAssertEqual(gvm.title, "test_title")
           XCTAssertEqual(gvm.description, "desc")
           XCTAssertEqual(gvm.typeImage, Images.runningIcon)
       }

    func testGoalViewModelStepIcon() throws {
        let gvm = GoalViewModel(goalable:
            Goal(id: "1000",
                 title: "test_title",
                 description: "desc",
                 type: "step",
                 goal: 5000,
                 trophy: "Medal",
                 points: 1000)
        )
        XCTAssertEqual(gvm.rewardText, "Reward: 1000")
        XCTAssertEqual(gvm.title, "test_title")
        XCTAssertEqual(gvm.description, "desc")
        XCTAssertEqual(gvm.typeImage, Images.stepIcon)
    }

    func testGoalViewModelDefaultIcon() throws {
        let gvm = GoalViewModel(goalable:
            Goal(id: "1000",
                 title: "test_title",
                 description: "desc",
                 type: "invalid_type",
                 goal: 5000,
                 trophy: "Medal",
                 points: 1000)
        )
        XCTAssertEqual(gvm.rewardText, "Reward: 1000")
        XCTAssertEqual(gvm.title, "test_title")
        XCTAssertEqual(gvm.description, "desc")
        XCTAssertEqual(gvm.typeImage, Images.stepIcon)
    }
}

/*

 struct GoalViewModel {
     private let goal: Goal

     var title: String {
         return goal.title
     }

     var description: String {
         return goal.description
     }

     var rewardText: String {
         return Localized.stringForKeyWithParams("reward", goal.reward.points)
     }

     var typeImage: UIImage? {
         switch goal.type {
         case .runningDistance, .walkingDistance:
             return Images.runningIcon
         case .step:
             return Images.stepIcon
         }
     }

     init(goalable: Goalable) {
         self.goal = goalable.asGoal()
     }
 }

 */
