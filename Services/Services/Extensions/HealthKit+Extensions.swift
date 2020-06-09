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
import RxSwift

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
            return Localized.errorHealthKitAccess
        case .authorizationError:
            return Localized.errorHealthKitAuth
        case .queryError:
            return Localized.errorHealthKitQuery
        case .unknown:
            return Localized.errorUnknown
        }
    }
}

extension HKHealthStore: ActivityService {
    func activityTypesToHKTypes(_ types: Set<ActivityType>) -> Set<HKObjectType>? {
        guard
            let distance = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning),
            let steps = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
                return nil
        }
        return Set(types.map { type in
            switch type {
            case .distance: return distance
            case .stepCount: return steps
            }
        })
    }

    // requestAuthorization: wrapper for HealthKit Authorization
    //
    public func requestAuthorization(types: Set<ActivityType>) -> Observable<Void> {
        return Observable.create { [weak self] observer in
            guard
                let hkTypes = self?.activityTypesToHKTypes(types),
                HKHealthStore.isHealthDataAvailable() else {
                observer.onError(HealthKitActivityProviderError.healthKitNotAvailableError)
                return Disposables.create()
            }
            self?.requestAuthorization(toShare: nil, read: hkTypes) { userWasShownPermissionView, _ in
                guard userWasShownPermissionView else {
                    observer.onError(HealthKitActivityProviderError.authorizationError)
                    return
                }
                observer.onNext(())
            }
            return Disposables.create()
        }
    }

    // getDaily: Generic fetching for HealthKit data
    //
    func getDaily(_ identifier: HKQuantityTypeIdentifier, in unit: HKUnit) -> Observable<Double> {
        return Observable.create { [weak self] observer in
            guard
                let self = self,
                let quantityType = HKQuantityType.quantityType(forIdentifier: identifier) else {
                observer.onError(HealthKitActivityProviderError.unknown)
                return Disposables.create()
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
                        observer.onError(HealthKitActivityProviderError.queryError)
                        return
                    }
                    observer.onNext(sum.doubleValue(for: unit))
            }
            self.execute(query)
            return Disposables.create()
        }
    }

    // getStepsAndDistance: Get daily steps and running/walking distance
    //
    public func getStepsAndDistance() -> Observable<Activity> {
        let distanceObs = self.getDaily(.distanceWalkingRunning, in: .meter())
        let stepsObs = self.getDaily(.stepCount, in: .count())

        return Observable.combineLatest(distanceObs, stepsObs) { distance, steps in
            return Activity(steps: steps, distance: distance)
        }
    }
}
