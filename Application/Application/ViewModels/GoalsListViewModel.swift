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
import RxCocoa

final class GoalsListViewModel {
    private let disposeBag = DisposeBag()
    private let mainProvider: MainProvider

    var goalables: [Goalable] = []
    let hideLoading = BehaviorRelay<Bool>(value: false)
    let title = Localized.appTitle

    init(mainProvider: MainProvider) {
        self.mainProvider = mainProvider
    }

    private func subscribeToLoading(_ obs: ConnectableObservable<[GoalViewModel]>) -> ConnectableObservable<[GoalViewModel]> {
        self.hideLoading.accept(true)
        obs.subscribe(onNext: { [weak self] _ in
            self?.hideLoading.accept(false)
        }, onError: { [weak self] _ in
            self?.hideLoading.accept(false)
        }).disposed(by: disposeBag)
        return obs
    }

    func fetchGoalViewModels() -> ConnectableObservable<[GoalViewModel]> {
        let obs: ConnectableObservable<[GoalViewModel]> = self.mainProvider
            .dataProvider
            .getGoals()
            .map { [weak self] in
                let vms = $0.map {
                    GoalViewModel(goalable: $0)
                }
                self?.goalables = $0
                return vms
            }.publish()
        return subscribeToLoading(obs)
    }
}
