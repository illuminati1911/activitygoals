//
//  AppDelegate.swift
//  Application
//
//  Created by Ville Välimaa on 2020/6/6.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import UIKit
import Services
import Networking
import LocalStorage
import HealthKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let activityProvider = HealthKitActivityProvider(activityService: HKHealthStore())
        let dataProvider = RemoteWithLocalDataProvider(remote: APIService(), local: CoreDataProvider())
        let mainVC = GoalsViewController(activityProvider: activityProvider, dataProvider: dataProvider)
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
        return true
    }
}
