//
//  MainViewController.swift
//  Application
//
//  Created by Ville Välimaa on 2020/6/8.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import UIKit
import Services

class MainViewController: UIViewController {
    let activityProvider: ActivityProvider
    let dataProvider: DataProvider

    init(activityProvider: ActivityProvider, dataProvider: DataProvider) {
        self.activityProvider = activityProvider
        self.dataProvider = dataProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
