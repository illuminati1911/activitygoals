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
    private let mainProvider: MainProvider
    private let goalable: Goalable

    var title: String { return goalable.asGoal().title }
    
    init(mainProvider: MainProvider, goalable: Goalable) {
        self.mainProvider = mainProvider
        self.goalable = goalable
    }

    func fetchActivityGoalViewModels() -> Observable<ActivityGoalViewModel> {
        return Observable.zip(
            mainProvider.activityProvider.getActivity(),
            Observable.from(optional: goalable)
        ).map {
            ActivityGoalViewModel(goalable: $1, activity: $0)
        }
    }
}
