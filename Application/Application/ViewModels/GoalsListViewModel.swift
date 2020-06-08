//
//  GoalsListViewModel.swift
//  Application
//
//  Created by Ville Välimaa on 2020/6/8.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import Services
import Core
import RxSwift

final class GoalsListViewModel {
    private let disposeBag = DisposeBag()
    private let mainProvider: MainProvider

    var goalables: [Goalable] = []
    let title = "Daily activity goals!"

    init(mainProvider: MainProvider) {
        self.mainProvider = mainProvider
    }

    func fetchGoalViewModels() -> Observable<[GoalViewModel]> {
        self.mainProvider
            .dataProvider
            .getGoals()
            .map { [weak self] in
                let vms = $0.map {
                    GoalViewModel(goalable: $0)
                }
                self?.goalables = $0
                return vms
            }
    }
}
