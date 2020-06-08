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

public class HealthKitActivityProvider: ActivityProvider {
    private let activityService: ActivityService

    public init(activityService: ActivityService) {
        self.activityService = activityService
    }

    public func getActivity(_ completion: @escaping (Result<Activity, Error>) -> Void) {
        guard
            let distance = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning),
            let steps = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
                completion(.failure(HealthKitActivityProviderError.healthKitNotAvailableError))
                return
        }
        let requestedTypes: Set<HKObjectType> = [
            distance,
            steps
        ]
        activityService.requestAuthorization(types: requestedTypes) { [weak self] result in
            guard let self = self else {
                completion(.failure(HealthKitActivityProviderError.unknown))
                return
            }
            switch result {
            case .success:
                self.activityService.getStepsAndDistance(completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }
}
