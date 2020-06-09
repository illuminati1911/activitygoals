//
//  GoalViewModel.swift
//  Application
//
//  Created by Ville Välimaa on 2020/6/8.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import UIKit
import Core

struct GoalViewModel {
    private let goal: Goal

    var displayText: String {
        return "\(goal.title) - \(goal.description)"
    }

    var title: String {
        return goal.title
    }

    var description: String {
        return goal.description
    }

    var rewardText: String {
        return "Reward: \(goal.reward.points)"
    }

    var typeImage: UIImage? {
        switch goal.type {
        case .runningDistance, .walkingDistance:
            return UIImage(named: "running")
        case .step:
            return UIImage(named: "step")
        }
    }

    init(goalable: Goalable) {
        self.goal = goalable.asGoal()
    }
}