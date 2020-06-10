//
//  CoreDataManager.swift
//  LocalStorage
//
//  Created by Ville Välimaa on 2020/6/6.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import CoreData
import Core
import RxSwift

/// CoreDataProviderError: Error type for CoreDataProvider
///
public enum CoreDataProviderError: Error {
    case createFailure
    case fetchFailure
    case unknown

    var localizedDescription: String {
        switch self {
        case .createFailure:
            return Localized.errorLocalStorageCreate
        case .fetchFailure:
            return Localized.errorLocalStorageFetch
        case .unknown:
            return Localized.errorUnknown
        }
    }
}

/// CoreDataProvider: LocalStorageProtocol conforming component for Core Data
///
public class CoreDataProvider: LocalStorageProtocol {
    private let goalEntityName = "CDGoal"

    private let persistentContainer: NSPersistentContainer

    public init(container: NSPersistentContainer) {
        self.persistentContainer = container
    }

    // createGoals: batch insert Goalable objects to Core Data
    //
    @discardableResult
    public func createGoals(goalables: [Goalable]) -> Observable<[Goalable]> {
        return Observable.create { observer in
            let context = self.persistentContainer.viewContext

            for goalable in goalables {
                guard let goal = NSEntityDescription.insertNewObject(forEntityName: self.goalEntityName, into: context) as? CDGoal else {
                    observer.onError(CoreDataProviderError.createFailure)
                    return Disposables.create()
                }

                goal.id = goalable.asGoal().id
                goal.title = goalable.asGoal().title
                goal.desc = goalable.asGoal().description
                goal.type = goalable.asGoal().type.rawValue
                goal.goal = Int64(goalable.asGoal().goal)
                goal.trophy = goalable.asGoal().reward.trophy
                goal.points = Int64(goalable.asGoal().reward.points)
            }

            do {
                try context.save()
            } catch {
                observer.onError(CoreDataProviderError.createFailure)
                return Disposables.create()
            }
            observer.onNext(goalables)
            return Disposables.create()
        }
    }

    // fetchGoals: fetch Goalables from Core Data
    //
    public func fetchGoals() -> Observable<[Goalable]> {
        return Observable.create { observer in
            let context = self.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<CDGoal>(entityName: self.goalEntityName)

            do {
                let goals = try context.fetch(fetchRequest)
                observer.onNext(goals)
            } catch {
                observer.onError(CoreDataProviderError.fetchFailure)
            }
            return Disposables.create()
        }
    }
}
