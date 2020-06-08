//
//  ActivityService.swift
//  Services
//
//  Created by Ville Välimaa on 2020/6/8.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import HealthKit
import Core

/// ActivityService: Any service that provides activity related data
///
public protocol ActivityService {
    func requestAuthorization(types: Set<HKObjectType>, _ completion: @escaping (Result<Void, Error>) -> Void)
    func getStepsAndDistance(_ completion: @escaping (Result<Activity, Error>) -> Void)
}
