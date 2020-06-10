//
//  Activity.swift
//  Core
//
//  Created by Ville Välimaa on 2020/6/7.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation

/// Activity: User's daily activity
///
public struct Activity {
    public let steps: Double
    public let distance: Double

    public init(steps: Double, distance: Double) {
        self.steps = steps
        self.distance = distance
    }
}
