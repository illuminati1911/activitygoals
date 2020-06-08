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

    private let imageView = UIImageView()

    private let dailyActivityLabel = with(UILabel()) {
        $0.textAlignment = .center
    }

    private let targetLabel = with(UILabel()) {
        $0.textAlignment = .center
    }

    private let statusLabel = with(UILabel()) {
        $0.textAlignment = .center
    }

    init(mainProvider: MainProvider, goalable: Goalable) {
        self.detailGoalViewModel = DetailGoalViewModel(mainProvider: mainProvider, goalable: goalable)
        super.init(mainProvider)
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
        navigationItem.title = detailGoalViewModel.title

        view.addSubview(imageView)
        view.addSubview(dailyActivityLabel)
        view.addSubview(targetLabel)
        view.addSubview(statusLabel)

        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(100)
            make.size.equalTo(150)
            make.centerX.equalToSuperview()
        }

        dailyActivityLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(imageView.snp.bottom).offset(20)
        }

        targetLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(dailyActivityLabel.snp.bottom).offset(20)
        }

        statusLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(targetLabel.snp.bottom).offset(20)
        }

        loadActivity()
    }
}
