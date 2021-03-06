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

/// LocalStorageProcotol: Protocol for any class that can persist Goalable objects
///
public protocol LocalStorageProtocol {
    @discardableResult
    func createGoals(goalables: [Goalable]) -> Observable<[Goalable]>
    func fetchGoals() -> Observable<[Goalable]>
    func deleteGoals() -> Observable<Void>
}
