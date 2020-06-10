//
//  HealthKitActivityProvider.swift
//  Services
//
//  Created by Ville Välimaa on 2020/6/7.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import Core
import HealthKit
import RxSwift

/// HealthKitActivityProvider: Implementation for providing HealthKit activity data
///
public class HealthKitActivityProvider: ActivityProvider {
    private let activityService: ActivityService

    public init(activityService: ActivityService) {
        self.activityService = activityService
    }

    public func getActivity() -> Observable<Activity> {
        let requestedTypes: Set<ActivityType> = [
            .distance,
            .stepCount
        ]

        return activityService
            .requestAuthorization(types: requestedTypes)
            .flatMap { [unowned self] _ in
                self.activityService.getStepsAndDistance()
            }
    }
}
