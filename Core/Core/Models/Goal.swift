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
public struct Goals: Decodable {
    public let items: [Goal]
}

public struct Reward: Decodable {
    public let trophy: String
    public let points: Int

    init(trophy: String, points: Int) {
        self.trophy = trophy
        self.points = points
    }
}

// Main activity goal type
//
public struct Goal: Decodable {
    public let id: String
    public let title: String
    public let description: String
    public let type: String // TODO change to enum
    public let goal: Int
    public let reward: Reward

    public init(id: String, title: String, description: String, type: String, goal: Int, trophy: String, points: Int) {
        self.id = id
        self.title = title
        self.description = description
        self.type = type
        self.goal = goal
        self.reward = Reward(trophy: trophy, points: points)
    }
}

extension Goal: Goalable {
    public func asGoal() -> Goal {
        return self
    }
}
