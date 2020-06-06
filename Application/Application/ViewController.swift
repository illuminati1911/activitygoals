//
//  ViewController.swift
//  Application
//
//  Created by Ville Välimaa on 2020/6/6.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import UIKit
import Networking
import RxSwift

class ViewController: UIViewController {

    let client = AGAPIClient()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.client
            .getDailyGoals()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { goals in
                print(goals)
        }, onError: { error in
            print(error)
        }).disposed(by: disposeBag)
    }
}
