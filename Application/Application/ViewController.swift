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
        networkProvider.getGoals()
            .subscribe(onNext: { goals in
                print("Hello")
                print(goals)
            }, onError: { _ in
                print("Error")
            })
        .disposed(by: disposeBag)
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
