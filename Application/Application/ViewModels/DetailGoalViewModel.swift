//
//  DetailGoalViewModel.swift
//  Application
//
//  Created by Ville Välimaa on 2020/6/8.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import Services
import Core
import RxSwift

final class DetailGoalViewModel {
    private let disposeBag = DisposeBag()
    private let activityProvider: ActivityProvider
    private let goalable: Goalable

    init(activityProvider: ActivityProvider, goalable: Goalable) {
        self.activityProvider = activityProvider
        self.goalable = goalable
    }

    func fetchActivityGoalViewModels() -> Observable<ActivityGoalViewModel> {
        return Observable.zip(activityProvider.getActivity(), Observable.from(optional: goalable))
            .map {
                ActivityGoalViewModel(goalable: $1, activity: $0)
            }
    }
}
