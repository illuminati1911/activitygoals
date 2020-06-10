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

/// GoalViewModel: View model for Goal/Goalable items
///
struct GoalViewModel {
    let goal: Goal

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
