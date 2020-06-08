//
//  MainProvider.swift
//  Services
//
//  Created by Ville Välimaa on 2020/6/8.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation

public protocol MainProvider {
    static func getApplicationProvider() -> MainProvider
    var dataProvider: DataProvider { get }
    var activityProvider: ActivityProvider { get }
}
