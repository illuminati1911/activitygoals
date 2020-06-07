//
//  LocalStorageProtocol.swift
//  LocalStorage
//
//  Created by Ville Välimaa on 2020/6/6.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import Core

public protocol LocalStorageProtocol {
    func createGoal(goalable: Goalable, _ completion: ((Result<Goalable, Error>) -> Void)?)
    func createGoals(goalables: [Goalable], _ completion: ((Result<[Goalable], Error>) -> Void)?)
    func fetchGoals(_ completion: @escaping (Result<[Goalable], Error>) -> Void)
}
