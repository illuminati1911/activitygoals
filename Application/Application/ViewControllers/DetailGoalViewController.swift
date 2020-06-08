//
//  DetailGoalViewController.swift
//  Application
//
//  Created by Ville Välimaa on 2020/6/8.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import UIKit
import Services
import Core
import RxSwift

class DetailGoalViewController: BaseViewController {
    private let disposeBag = DisposeBag()
    private var detailGoalViewModel: DetailGoalViewModel

    init(activityProvider: ActivityProvider, dataProvider: DataProvider, goalable: Goalable) {
        self.detailGoalViewModel = DetailGoalViewModel(activityProvider: activityProvider, goalable: goalable)
        super.init(activityProvider: activityProvider, dataProvider: dataProvider)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        detailGoalViewModel
            .fetchActivityGoalViewModels()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { activityGoalVM in
            print(activityGoalVM.displayDailyActivityText)
            print(activityGoalVM.statusText)
        }, onError: { error in
            print("Error")
            print(error)
        }).disposed(by: disposeBag)
    }
}
