//
//  Mocks.swift
//  ApplicationTests
//
//  Created by Ville Välimaa on 2020/6/10.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import Services
import Networking
import Core
import RxSwift

class MockMainProvider: MainProvider {
    static func getApplicationProvider() -> MainProvider {
        return MockMainProvider(shouldFail: true)
    }

    var dataProvider: DataProvider
    var activityProvider: ActivityProvider

    init(shouldFail: Bool) {
        self.dataProvider = MockDataProvider(fail: shouldFail)
        self.activityProvider = MockActivityProvider(fail: shouldFail)
    }
}

class MockActivityProvider: ActivityProvider {
    private let fail: Bool

    init(fail: Bool) {
        self.fail = fail
    }

    func getActivity() -> Observable<Activity> {
        return Observable.create { observer in
            if self.fail {
                observer.onError(HealthKitActivityProviderError.healthKitNotAvailableError)
            } else {
                observer.onNext(Activity(steps: 3000, distance: 1000))
            }
            return Disposables.create()
        }
    }
}

class MockDataProvider: DataProvider {
    private let fail: Bool

    init(fail: Bool) {
        self.fail = fail
    }

    func getGoals() -> Observable<[Goalable]> {
        return Observable.create { observer in
            if self.fail {
                observer.onError(APIError.requestFailure)
            } else {
                observer.onNext([Goal(id: "1000",
                                     title: "test_title",
                                     description: "desc",
                                     type: "invalid_type",
                                     goal: 5000,
                                     trophy: "Medal",
                                     points: 1000)])
            }
            return Disposables.create()
        }
    }
}
