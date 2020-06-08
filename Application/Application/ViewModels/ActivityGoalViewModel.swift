//
//  ActivityGoalViewModel.swift
//  Application
//
//  Created by Ville Välimaa on 2020/6/8.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import Core

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
            return "meters"
        case .step:
            return "steps"
        }
    }

    var displayDailyActivityText: String {
        return "Your daily activity: \(activity.steps.asInt()) steps, \(activity.distance.asInt()) meters"
    }

    var goalTarget: String {
        return "Target: \(goal.goal) \(unit)"
    }

    var statusText: String {
        return goalOffset <= 0
            ? "Goal completed!"
            : "Still \(goalOffset) \(unit) left"
    }

    init(goalable: Goalable, activity: Activity) {
        self.goal = goalable.asGoal()
        self.activity = activity
    }
}
