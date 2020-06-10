//
//  DetailGoalCoordinator.swift
//  Application
//
//  Created by Ville Välimaa on 2020/6/8.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Services
import Core

/// DetailGoalCoordinator: Coordinator for DetailGoalViewController
///
final class DetailGoalCoordinator: Coordinator {
    private let presenter: UINavigationController
    private var detailGoalViewController: DetailGoalViewController?
    private let goalable: Goalable
    private let mainProvider: MainProvider

    init(presenter: UINavigationController, mainProvider: MainProvider, goalable: Goalable) {
        self.presenter = presenter
        self.mainProvider = mainProvider
        self.goalable = goalable
    }

    func start() {
        let detailGoalViewController = DetailGoalViewController(
            mainProvider: mainProvider,
            goalable: goalable
        )
        self.detailGoalViewController = detailGoalViewController
        presenter.pushViewController(detailGoalViewController, animated: true)

    }
}
