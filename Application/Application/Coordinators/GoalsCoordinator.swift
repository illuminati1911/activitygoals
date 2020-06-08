//
//  GoalsCoordinator.swift
//  Application
//
//  Created by Ville Välimaa on 2020/6/8.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import UIKit
import Services
import RxSwift
import Core

final class GoalsCoordinator: Coordinator {
    private let diposeBag = DisposeBag()
    private var presenter: UINavigationController
    private var detailGoalCoordinator: DetailGoalCoordinator?
    private var goalsViewController: GoalsViewController?
    private var mainProvider: MainProvider

    init(presenter: UINavigationController, mainProvider: MainProvider) {
        self.presenter = presenter
        self.mainProvider = mainProvider
    }

    func start() {
        let goalsViewController = GoalsViewController(mainProvider)
        self.goalsViewController = goalsViewController
        self.goalsViewController?
            .selectedGoal
            .subscribe(onNext: { [weak self] goalable in
                guard let self = self else { return }
                let detailGoalCoordinator = DetailGoalCoordinator(
                    presenter: self.presenter,
                    mainProvider: self.mainProvider,
                    goalable: goalable)
                self.detailGoalCoordinator = detailGoalCoordinator
                detailGoalCoordinator.start()
            }).disposed(by: diposeBag)
        presenter.pushViewController(goalsViewController, animated: true)
    }
}
