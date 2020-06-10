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
import RxSwift

/// RemoteWithLocalDataProviderError: Error type for Data Provider errors
///
public enum RemoteWithLocalDataProviderError: Error {
    case unknown

    var localizedDescription: String {
        switch self {
        case .unknown:
            return Localized.errorUnknown
        }
    }
}

/// RemoteWithLocalDataProvider: Implementation for providing Goals data from network or local cache
///
public class RemoteWithLocalDataProvider: DataProvider {
    private let remote: APIServiceProtocol
    private let local: LocalStorageProtocol
    private let disposeBag = DisposeBag()

    public init(remote: APIServiceProtocol, local: LocalStorageProtocol) {
        self.remote = remote
        self.local = local
    }

    // syncToLocalStorage: Sync goals to local storage
    // Core Data on main thread for safety
    //
    private func syncToLocalStorage(_ goalables: [Goalable]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.local
                .deleteGoals()
                .flatMap {
                    self.local.createGoals(goalables: goalables)
                }.subscribe()
                .disposed(by: self.disposeBag)
        }
    }

    // getGoals: Fetch goals from remote network and sync to local storage
    // if fetching fails, look for the goals from local storage
    //
    public func getGoals() -> Observable<[Goalable]> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                observer.onError(RemoteWithLocalDataProviderError.unknown)
                return Disposables.create()
            }

            // Nested subscription since swift compiler can't keep up with the generics
            // in flatMap pipeline. Will investigate better solution later on.
            //
            self.remote.getGoals()
                .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .subscribe(onNext: { goalables in
                    self.syncToLocalStorage(goalables)
                    observer.onNext(goalables)
                }, onError: { error in
                    self.local.fetchGoals()
                        .subscribe(onNext: { goalables in
                            observer.onNext(goalables)
                        }, onError: { error in
                            observer.onError(error)
                        }).disposed(by: self.disposeBag)
                }).disposed(by: self.disposeBag)

            return Disposables.create()
        }
    }
}
