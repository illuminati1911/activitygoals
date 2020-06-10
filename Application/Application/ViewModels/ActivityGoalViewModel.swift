//
//  ActivityGoalViewModel.swift
//  Application
//
//  Created by Ville Välimaa on 2020/6/8.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import UIKit
import Core

/// ActivityGoalViewModel: View model for each activity item.
///
struct ActivityGoalViewModel {
    private let goal: Goal
    private let activity: Activity

    private var goalOffset: Int {
        switch goal.type {
        case .runningDistance, .walkingDistance:
            return goal.goal - activity.distance.asInt()
        case .step:
            return goal.goal - activity.steps.asInt()
        }
    }

    private var unit: String {
        switch goal.type {
        case .runningDistance, .walkingDistance:
            return Localized.unitMeters
        case .step:
            return Localized.unitSteps
        }
    }

    var displayDailyActivityText: String {
        return Localized.stringForKeyWithParams("daily_activity", activity.steps.asInt(), activity.distance.asInt())
    }

    var goalTargetText: String {
        return Localized.stringForKeyWithParams("goal_target", goal.goal, unit)
    }

    var statusText: String {
        return goalOffset <= 0
            ? Localized.goalCompleted
            : Localized.stringForKeyWithParams("goal_remaining", goalOffset, unit)
    }

    var typeImage: UIImage? {
        switch goal.type {
        case .runningDistance, .walkingDistance:
            return UIImage(named: "running")
        case .step:
            return UIImage(named: "step")
        }
    }

    var titleText: String { return goal.title }

    init(goalable: Goalable, activity: Activity) {
        self.goal = goalable.asGoal()
        self.activity = activity
    }
}
