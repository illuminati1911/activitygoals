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

/// GoalsViewController is the main view controller of the app.
/// It displays the goals fetched from network or local storage.
///
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

    private let refreshControl = UIRefreshControl()

    private let loadingSpinner = with(UIActivityIndicatorView()) {
        if #available(iOS 13.0, *) {
            $0.style = .large
        } else {
            $0.style = .gray
        }
    }

    private var goalsListViewModel: GoalsListViewModel

    override init(_ mainProvider: MainProvider) {
        self.goalsListViewModel = GoalsListViewModel(mainProvider: mainProvider)
        super.init(mainProvider)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func fetchGoals() {
        let fetchGoals = goalsListViewModel
            .fetchGoalViewModels()

        fetchGoals
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.refreshControl.endRefreshing()
            }, onError: { [weak self] error in
                self?.refreshControl.endRefreshing()
                self?.showAlert(Localized.errorTitle, description: error.localizedDescription)
            }).disposed(by: disposeBag)

        fetchGoals
            .connect()
            .disposed(by: disposeBag)
    }

    func setupObservables() {
        goalsListViewModel
            .hideLoading
            .asObservable()
            .observeOn(MainScheduler.instance)
            .bind(to: loadingSpinner.rx.isAnimating)
            .disposed(by: disposeBag)

        goalsListViewModel
            .dataSource
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: GoalTableViewCell.identifier,
                                         cellType: GoalTableViewCell.self)) { _, viewModel, cell in
                cell.goalViewModel = viewModel
            }.disposed(by: disposeBag)

        tableView
            .rx
            .itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.tableView.deselectRow(at: indexPath, animated: true)
                guard let goalable = self?.goalsListViewModel.dataSource.value[indexPath.row].goal else { return }
                self?.selectedGoalSubject.onNext(goalable)
            }).disposed(by: disposeBag)

        self.refreshControl.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] in
                self?.fetchGoals()
            })
            .disposed(by: disposeBag)
    }

    func setupViews() {
        navigationItem.title = goalsListViewModel.title
        view.addSubview(tableView)
        view.addSubview(loadingSpinner)
        view.backgroundColor = .white

        tableView.contentInsetAdjustmentBehavior = .always
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.refreshControl = refreshControl

        loadingSpinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupObservables()
        fetchGoals()
    }
}
