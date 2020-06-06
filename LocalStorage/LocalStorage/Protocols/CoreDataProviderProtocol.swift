//
//  LocalProviderProtocol.swift
//  LocalStorage
//
//  Created by Ville Välimaa on 2020/6/6.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import RxSwift

public protocol CoreDataProviderProtocol {
    func createGoal(id: String, title: String, desc: String, type: String, gl: Int64, trophy: String, points: Int64) -> Observable<Void>
    func fetchGoals() -> Observable<[CDGoal]>
}
