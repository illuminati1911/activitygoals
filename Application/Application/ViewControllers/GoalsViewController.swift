//
//  GoalsViewController.swift
//  Application
//
//  Created by Ville Välimaa on 2020/6/8.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import UIKit
import RxSwift
import Services
import Core
import SnapKit
import RxCocoa

final class GoalsViewController: BaseViewController {
    private var selectedGoalSubject = PublishSubject<Goalable>()
    var selectedGoal: Observable<Goalable> {
        return selectedGoalSubject.asObservable()
    }
    private let disposeBag = DisposeBag()
    private let tableView = with(UITableView()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tableFooterView = UIView()
        $0.register(GoalTableViewCell.self, forCellReuseIdentifier: GoalTableViewCell.identifier)
        $0.contentInsetAdjustmentBehavior = .never
    }
    private var goalsListViewModel: GoalsListViewModel

    override init(_ mainProvider: MainProvider) {
        self.goalsListViewModel = GoalsListViewModel(mainProvider: mainProvider)
        super.init(mainProvider)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureTableView() {
        view.addSubview(tableView)
        view.backgroundColor = .white
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.bottom.equalToSuperview()
        }

        // Bind observer to tableView
        //
        goalsListViewModel
            .fetchGoalViewModels()
            .observeOn(MainScheduler.instance)
            .catchError { _ in Observable.never() }
            .bind(to: tableView.rx.items(cellIdentifier: GoalTableViewCell.identifier, cellType: GoalTableViewCell.self)) { _, viewModel, cell in
                cell.goalViewModel = viewModel
            }.disposed(by: disposeBag)

        goalsListViewModel
            .fetchGoalViewModels()
            .subscribe(onError: { [weak self] error in
                self?.showAlert("Error", description: error.localizedDescription)
            }).disposed(by: disposeBag)

        tableView
            .rx
            .itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.tableView.deselectRow(at: indexPath, animated: true)
                guard let goalable = self?.goalsListViewModel.goalables[indexPath.row] else { return }
                self?.selectedGoalSubject.onNext(goalable)
            }).disposed(by: disposeBag)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Activity Goals 🏆"
        configureTableView()
    }
}
