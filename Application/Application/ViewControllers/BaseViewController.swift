//
//  BaseViewController.swift
//  Application
//
//  Created by Ville Välimaa on 2020/6/8.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import UIKit
import Services

/// BaseViewController: Base view controller for all the viewcontrollers in the app.
/// Will managed dependency injections etc.
///
class BaseViewController: UIViewController {
    let mainProvider: MainProvider

    init(_ mainProvider: MainProvider) {
        self.mainProvider = mainProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
