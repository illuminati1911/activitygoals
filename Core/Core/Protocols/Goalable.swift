//
//  Goalable.swift
//  Core
//
//  Created by Ville Välimaa on 2020/6/6.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation

/// Goalable: Anything that can be converted into a Goal
///
public protocol Goalable {
    func asGoal() -> Goal
}
