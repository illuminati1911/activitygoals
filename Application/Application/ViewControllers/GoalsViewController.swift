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

final class GoalsViewController: MainViewController {
    private let disposeBag = DisposeBag()
    private let tableView = with(UITableView()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tableFooterView = UIView()
        $0.register(GoalTableViewCell.self, forCellReuseIdentifier: GoalTableViewCell.identifier)
    }
    private var goalsListViewModel: GoalsListViewModel

    override init(activityProvider: ActivityProvider, dataProvider: DataProvider) {
        self.goalsListViewModel = GoalsListViewModel(dataProvider: dataProvider)
        super.init(activityProvider: activityProvider, dataProvider: dataProvider)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        // Bind observer to tableView
        //
        goalsListViewModel
            .fetchGoalViewModels()
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: GoalTableViewCell.identifier, cellType: GoalTableViewCell.self)) { _, viewModel, cell in
                cell.goalViewModel = viewModel
        }.disposed(by: disposeBag)

        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: true)
            print("Hello \(indexPath.row)")
            print(self?.goalsListViewModel.goalViewModels[indexPath.row])
        }).disposed(by: disposeBag)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        configureTableView()
    }
}
