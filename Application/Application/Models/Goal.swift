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
struct Goals: Decodable {
    let items: [Goal]
}

struct Reward: Decodable {
    let trophy: String
    let points: Int
}

// Main activity goal type
//
struct Goal: Decodable {
    let id: String
    let title: String
    let description: String
    let type: String // TODO change to enum
    let goal: Int
    let reward: Reward
}
