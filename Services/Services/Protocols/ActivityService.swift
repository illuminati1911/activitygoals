//
//  ActivityService.swift
//  Services
//
//  Created by Ville Välimaa on 2020/6/8.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import HealthKit
import Core
import RxSwift

public enum ActivityType {
    case distance
    case stepCount
}

/// ActivityService: Any service that provides activity related data
///
public protocol ActivityService {
    func requestAuthorization(types: Set<ActivityType>) -> Observable<Void>
    func getStepsAndDistance() -> Observable<Activity>
}
