//
//  LocalStorageProtocol.swift
//  LocalStorage
//
//  Created by Ville Välimaa on 2020/6/6.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import Core
import RxSwift

public protocol LocalStorageProtocol {
    func createGoal(goalable: Goalable) -> Observable<Goalable>
    func createGoals(goalables: [Goalable]) -> Observable<[Goalable]>
    func fetchGoals() -> Observable<[Goalable]>
}
