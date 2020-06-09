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

    func setupObservables() {
        goalsListViewModel
            .hideLoading
            .asObservable()
            .observeOn(MainScheduler.instance)
            .bind(to: loadingSpinner.rx.isAnimating)
            .disposed(by: disposeBag)

        // Bind observer to tableView
        //
        let fetchGoals = goalsListViewModel
            .fetchGoalViewModels()
            .share()

        fetchGoals
            .observeOn(MainScheduler.instance)
            .catchError { _ in Observable.never() }
            .bind(to: tableView.rx.items(cellIdentifier: GoalTableViewCell.identifier,
                                         cellType: GoalTableViewCell.self)) { _, viewModel, cell in
                cell.goalViewModel = viewModel
            }.disposed(by: disposeBag)

        fetchGoals
            .subscribe(onError: { [weak self] error in
                self?.showAlert(Localized.errorTitle, description: error.localizedDescription)
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

    func setupViews() {
        navigationItem.title = goalsListViewModel.title
        view.addSubview(tableView)
        view.addSubview(loadingSpinner)
        view.backgroundColor = .white

        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.bottom.equalToSuperview()
        }

        loadingSpinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupObservables()
    }
}
