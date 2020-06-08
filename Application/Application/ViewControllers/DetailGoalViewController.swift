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

final class DetailGoalViewController: BaseViewController {
    private let disposeBag = DisposeBag()
    private var detailGoalViewModel: DetailGoalViewModel

    private let titleLabel = with(UILabel()) {
        $0.text = "Goal!"
    }

    private let imageView = UIImageView()

    private let goalLabel = with(UILabel()) {
        $0.text = "Run 500 meters!"
    }

    private let dailyActivityLabel = with(UILabel()) {
        $0.text = "You have run 100 meters!"
    }

    private let targetLabel = with(UILabel()) {
        $0.text = "Run 500m"
    }

    private let statusLabel = with(UILabel()) {
        $0.text = "Still 400m to go"
    }

    init(activityProvider: ActivityProvider, dataProvider: DataProvider, goalable: Goalable) {
        self.detailGoalViewModel = DetailGoalViewModel(activityProvider: activityProvider, goalable: goalable)
        super.init(activityProvider: activityProvider, dataProvider: dataProvider)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func loadActivity() {
        detailGoalViewModel
            .fetchActivityGoalViewModels()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] activityGoalVM in
                self?.imageView.image = activityGoalVM.typeImage
                self?.goalLabel.text = activityGoalVM.titleText
                self?.dailyActivityLabel.text = activityGoalVM.displayDailyActivityText
                self?.targetLabel.text = activityGoalVM.goalTargetText
                self?.statusLabel.text = activityGoalVM.statusText

        }, onError: { error in
            print("Error")
            print(error)
        }).disposed(by: disposeBag)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(imageView)
        view.addSubview(goalLabel)
        view.addSubview(dailyActivityLabel)
        view.addSubview(targetLabel)
        view.addSubview(statusLabel)

        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.size.equalTo(150)
            make.centerX.equalToSuperview()
        }

        goalLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(20)
        }

        dailyActivityLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(goalLabel.snp.bottom).offset(20)
        }

        targetLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(dailyActivityLabel.snp.bottom).offset(20)
        }

        statusLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(targetLabel.snp.bottom).offset(20)
        }

        loadActivity()
    }
}
