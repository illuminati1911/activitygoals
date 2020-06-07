//
//  ViewController.swift
//  Application
//
//  Created by Ville Välimaa on 2020/6/6.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import UIKit
import Core
import Services
import LocalStorage
import Networking
import RxSwift

class ViewController: UIViewController {
    let localProvider = CoreDataProvider()
    let networkProvider = APIService()
    var provider: DataProvider?
    var activity: ActivityProvider?
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
//        provider = RemoteWithLocalDataProvider(remote: networkProvider, local: localProvider)
//        provider?.getGoals()
//            .subscribe(onNext: { goalables in
//                print("KYLLÄ")
//                print(goalables)
//            }, onError: { error in
//                print("ERRORI")
//                print(error)
//            }).disposed(by: disposeBag)
//        let goal1 = Goal(id: "101", title: "Testi", description: "dfssdf", type: "dfsd", goal: 44, trophy: "dfsd", points: 567)
//        let goal2 = Goal(id: "102", title: "Testi", description: "dfssdf", type: "dfsd", goal: 44, trophy: "dfsd", points: 567)
//        let goal3 = Goal(id: "103", title: "Testi", description: "dfssdf", type: "dfsd", goal: 44, trophy: "dfsd", points: 567)
//        let goal4 = Goal(id: "104", title: "Testi", description: "dfssdf", type: "dfsd", goal: 44, trophy: "dfsd", points: 567)
        localProvider
            //.createGoals(goalables: [goal1, goal2, goal3, goal4])
            .fetchGoals()
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { goals in
                print("YEAH")
                let lol = goals.map { $0.asGoal() }
                print(lol)
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)
//        networkProvider.getGoals()
//            .subscribe(onNext: { goals in
//                print("Hello")
//                print(goals)
//            }, onError: { _ in
//                print("Error")
//            })
//        .disposed(by: disposeBag)
//        provider = RemoteWithLocalDataProvider(remote: networkProvider, local: localProvider)
//        self.provider?.getGoals { result in
//            switch result {
//            case .success(let goalables):
//                print(goalables)
//            case .failure(let error):
//                print(error)
//            }
//        }
//        activity = HealthKitActivityProvider()
//        activity?.getActivity({ result in
//            switch result {
//            case .success(let activity):
//                print(activity)
//            case .failure(let error):
//                print(error)
//            }
//        })

    }
}
