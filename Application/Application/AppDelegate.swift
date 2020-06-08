//
//  AppDelegate.swift
//  Application
//
//  Created by Ville Välimaa on 2020/6/6.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import UIKit
import Services

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?
    var mainProvider: MainProvider?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow()
        let mainProvider = AppProvider.getApplicationProvider()
        self.window = window
        self.mainProvider = mainProvider
        coordinator = AppCoordinator(window: window, mainProvider: mainProvider)
        coordinator?.start()
        return true
    }
}
