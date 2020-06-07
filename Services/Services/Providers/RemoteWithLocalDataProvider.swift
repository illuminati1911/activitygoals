//
//  RemoteWithLocalGoalsProvider.swift
//  Services
//
//  Created by Ville Välimaa on 2020/6/6.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import Networking
import LocalStorage
import Core

public class RemoteWithLocalDataProvider: DataProvider {
    private let remote: APIServiceProtocol
    private let local: LocalStorageProtocol

    public init(remote: APIServiceProtocol, local: LocalStorageProtocol) {
        self.remote = remote
        self.local = local
    }

    private func syncToLocalStorage(_ goalables: [Goalable]) {
        // Core Data on main thread for safety
        //
        DispatchQueue.main.async {
            self.local.createGoals(goalables: goalables, nil)
        }
    }

    public func getGoals(_ completion: @escaping (Result<[Goalable], Error>) -> Void) {
        self.remote.getGoals() /*{ [weak self] result in
            switch result {
            case .success(let goalables):
                self?.syncToLocalStorage(goalables)
                completion(.success(goalables))
            case .failure:
                self?.local.fetchGoals(completion)
            }
        }*/
    }
}
