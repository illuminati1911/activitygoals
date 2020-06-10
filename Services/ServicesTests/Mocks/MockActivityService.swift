//
//  MockActivityService.swift
//  ServicesTests
//
//  Created by Ville Välimaa on 2020/6/8.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import Core
import RxSwift
import HealthKit

class MockActivityService: ActivityService {
    private var allowAccess = false

    init(allowAccess: Bool) {
        self.allowAccess = allowAccess
    }
    func requestAuthorization(types: Set<ActivityType>) -> Observable<Void> {
        return Observable.create { [unowned self] observer in
            if !self.allowAccess {
                observer.onError(HealthKitActivityProviderError.authorizationError)
            } else {
                observer.onNext(())
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }

    func getStepsAndDistance() -> Observable<Activity> {
        return Observable.from(optional: Activity(steps: 5000, distance: 10000))
    }
}
