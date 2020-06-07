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

class ViewController: UIViewController {

    //let disposeBag = DisposeBag()
    let localProvider = CoreDataProvider()
    let networkProvider = APIService()
    var provider: DataProvider?

    override func viewDidLoad() {
        super.viewDidLoad()
        provider = RemoteWithLocalDataProvider(remote: networkProvider, local: localProvider)
        self.provider?.getGoals { result in
            switch result {
            case .success(let goalables):
                print(goalables)
            case .failure(let error):
                print(error)
            }
        }
    }
}
