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
    private let dataProvider: DataProvider

    var goalables: [Goalable] = []
    let title = "Daily activity goals!"

    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }

    func fetchGoalViewModels() -> Observable<[GoalViewModel]> {
        self.dataProvider
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
