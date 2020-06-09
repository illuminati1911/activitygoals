//
//  AppProvider.swift
//  Services
//
//  Created by Ville Välimaa on 2020/6/8.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import HealthKit
import Networking
import LocalStorage

public class AppProvider: MainProvider {
    public var dataProvider: DataProvider = RemoteWithLocalDataProvider(remote: APIService(), local: CoreDataProvider())
    public var activityProvider: ActivityProvider = HealthKitActivityProvider(activityService: HKHealthStore())

    public static func getApplicationProvider() -> MainProvider {
        return AppProvider()
    }
}
