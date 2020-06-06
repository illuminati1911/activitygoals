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
import LocalStorage

class ViewController: UIViewController {

    let client = AGAPIClient()
    let disposeBag = DisposeBag()
    let localProvider: CoreDataProviderProtocol = CoreDataProvider()

    override func viewDidLoad() {
        super.viewDidLoad()
        /*self.client
            .getDailyGoals()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { goals in
                print(goals)
        }, onError: { error in
            print(error)
        }).disposed(by: disposeBag)*/
        //manager.createGoal(id: "1", title: "Paska", desc: "Kakka ahisee", type: "joku", gl: 300, trophy: "Nalle", points: 64)

        // Core Data
        /*let create = localProvider.createGoal(id: "2", title: "Paska", desc: "Kakka ahisee", type: "joku", gl: 300, trophy: "Nalle", points: 64)
        let fetch = localProvider.fetchGoals()
        create
            .flatMap { fetch }
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { goals in
                print(goals[0].title)
                print(goals.count)
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)*/
    }
}
