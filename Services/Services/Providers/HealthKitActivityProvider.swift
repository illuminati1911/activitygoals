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

public class HealthKitActivityProvider: ActivityProvider {
    private let activityService: ActivityService

    public init(activityService: ActivityService) {
        self.activityService = activityService
    }

    public func getActivity() -> Observable<Activity> {
        guard
            let distance = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning),
            let steps = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
                return Observable.create { observer in
                    observer.onError(HealthKitActivityProviderError.healthKitNotAvailableError)
                    return Disposables.create()
                }
        }
        let requestedTypes: Set<HKObjectType> = [
            distance,
            steps
        ]

        return activityService
            .requestAuthorization(types: requestedTypes)
            .flatMap { [unowned self] _ in
                self.activityService.getStepsAndDistance()
            }
    }
}
