//
//  GoalViewModel.swift
//  Application
//
//  Created by Ville Välimaa on 2020/6/8.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import Core

struct GoalViewModel {
    private let goal: Goal

    var displayText: String {
        return "\(goal.title) - \(goal.description)"
    }

    var rewardText: String {
        return "Reward: \(goal.reward.points)"
    }

    init(goalable: Goalable) {
        self.goal = goalable.asGoal()
    }
}
