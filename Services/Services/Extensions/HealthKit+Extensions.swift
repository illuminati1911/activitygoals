//
//  HealthKit+Extensions.swift
//  Services
//
//  Created by Ville Välimaa on 2020/6/7.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import HealthKit
import Core

/// HealthKitActivityProviderErrorr: Error type for HealthKit requests
///
public enum HealthKitActivityProviderError: Error {
    case healthKitNotAvailableError
    case authorizationError
    case queryError
    case unknown

    var localizedDescription: String {
        switch self {
        case .healthKitNotAvailableError:
            return "Unable to access HealthKit"
        case .authorizationError:
            return "HealthKit Authorization error"
        case .queryError:
            return "HealthKit data query error"
        case .unknown:
            return "Unknown error"
        }
    }
}

public extension HKHealthStore {
    // requestAuthorization: wrapper for HealthKit Authorization
    //
    func requestAuthorization(types: Set<HKObjectType>, _ completion: @escaping (Result<Void, Error>) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
                completion(.failure(HealthKitActivityProviderError.healthKitNotAvailableError))
            return
        }
        self.requestAuthorization(toShare: nil, read: types) { userWasShownPermissionView, _ in
            guard userWasShownPermissionView else {
                completion(.failure(HealthKitActivityProviderError.authorizationError))
                return
            }
            completion(.success(()))
        }
    }

    // getDaily: Generic fetching for HealthKit data
    //
    func getDaily(_ identifier: HKQuantityTypeIdentifier, in unit: HKUnit, _ completion: @escaping (Result<Double, Error>) -> Void) {
        guard let quantityType = HKQuantityType.quantityType(forIdentifier: identifier) else {
            return
        }
        let predicate = HKQuery.predicateForSamples(
            withStart: Calendar.current.startOfDay(for: Date()),
            end: Calendar.current.startOfDay(for: Date()),
            options: .strictStartDate
        )

        let query = HKStatisticsQuery(quantityType: quantityType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else {
                completion(.failure(HealthKitActivityProviderError.queryError))
                return
            }
                completion(.success(sum.doubleValue(for: unit)))
        }
        self.execute(query)
    }

    // TODO: Change to RxSwift
    // getStepsAndDistance: Get daily steps and running/walking distance
    //
    func getStepsAndDistance(_ completion: @escaping (Result<Activity, Error>) -> Void) {
        self.getDaily(.distanceWalkingRunning, in: .meter()) { [weak self] result in
            guard let self = self else {
                completion(.failure(HealthKitActivityProviderError.unknown))
                return
            }
            switch result {
            case .success(let distance):
                self.getDaily(.stepCount, in: .count()) { resultSteps in
                    switch resultSteps {
                    case .success(let steps):
                        completion(.success(Activity(steps: steps, distance: distance)))
                        return
                    case .failure(let error):
                        completion(.failure(error))
                        return
                    }
                }
            case .failure(let error):
                completion(.failure(error))
                return
            }
        }
    }
}
