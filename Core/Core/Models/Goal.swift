//
//  Goal.swift
//  Application
//
//  Created by Ville Välimaa on 2020/6/6.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation

// Intermediate type for API call
//
public struct Goals: Codable {
    public let items: [Goal]

    public init(items: [Goal]) {
        self.items = items
    }
}

public struct Reward: Codable {
    public let trophy: String
    public let points: Int

    init(trophy: String, points: Int) {
        self.trophy = trophy
        self.points = points
    }
}

// Main activity goal type
//
public struct Goal: Codable {
    public enum GoalType: String, Codable {
      case step = "step"
      case walkingDistance = "walking_distance"
      case runningDistance = "running_distance"
    }
    public let id: String
    public let title: String
    public let description: String
    public let type: GoalType
    public let goal: Int
    public let reward: Reward

    public init(id: String, title: String, description: String, type: String, goal: Int, trophy: String, points: Int) {
        self.id = id
        self.title = title
        self.description = description
        self.type = GoalType(rawValue: "type") ?? .step
        self.goal = goal
        self.reward = Reward(trophy: trophy, points: points)
    }
}

extension Goal: Goalable {
    public func asGoal() -> Goal {
        return self
    }
}
