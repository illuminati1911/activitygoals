//
//  CDGoal+Goalable.swift
//  LocalStorage
//
//  Created by Ville Välimaa on 2020/6/6.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import Core

/// CDGoal: Extension to conform to Goalable protocol
///
extension CDGoal: Goalable {
    public func asGoal() -> Goal {
        return Goal(
            id: self.id ?? "",
            title: self.title ?? "",
            description: self.desc ?? "",
            type: self.type ?? "",
            goal: Int(exactly: self.goal) ?? 0,
            trophy: self.trophy ?? "",
            points: Int(exactly: self.points) ?? 0
        )
    }
}
