//
//  AppCoordinator.swift
//  Application
//
//  Created by Ville Välimaa on 2020/6/8.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import UIKit
import Services

final class AppCoordinator: Coordinator {
    private let window: UIWindow
    private let rootViewController: UINavigationController
    private var goalsCoordinator: GoalsCoordinator?
    private var appProvider: MainProvider

    init(window: UIWindow, mainProvider: MainProvider) {
        self.window = window
        appProvider = AppProvider.getApplicationProvider()
        rootViewController = UINavigationController()
        rootViewController.navigationBar.prefersLargeTitles = true
        goalsCoordinator = GoalsCoordinator(
            presenter: rootViewController,
            mainProvider: mainProvider
        )
    }

    func start() {
        window.rootViewController = rootViewController
        goalsCoordinator?.start()
        window.makeKeyAndVisible()
    }
}
