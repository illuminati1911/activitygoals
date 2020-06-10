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
    case deleteFailure
    case unknown

    var localizedDescription: String {
        switch self {
        case .createFailure:
            return Localized.errorLocalStorageCreate
        case .fetchFailure:
            return Localized.errorLocalStorageFetch
        case .deleteFailure:
        return Localized.errorLocalStorageDelete
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

    private var fetchRequest: NSFetchRequest<CDGoal> {
        return NSFetchRequest<CDGoal>(entityName: self.goalEntityName)
    }

    private var deleteRequest: NSBatchDeleteRequest {
        let deleteFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.goalEntityName)
        return NSBatchDeleteRequest(fetchRequest: deleteFetchRequest)
    }

    private var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }

    // createGoals: batch insert Goalable objects to Core Data
    //
    @discardableResult
    public func createGoals(goalables: [Goalable]) -> Observable<[Goalable]> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                observer.onError(CoreDataProviderError.createFailure)
                return Disposables.create()
            }
            for goalable in goalables {
                guard let goal = NSEntityDescription.insertNewObject(
                    forEntityName: self.goalEntityName,
                    into: self.context) as? CDGoal else {
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
                try self.context.save()
            } catch {
                observer.onError(CoreDataProviderError.createFailure)
                return Disposables.create()
            }
            observer.onNext(goalables)
            observer.onCompleted()
            return Disposables.create()
        }
    }

    // fetchGoals: fetch Goalables from Core Data
    //
    public func fetchGoals() -> Observable<[Goalable]> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                observer.onError(CoreDataProviderError.fetchFailure)
                return Disposables.create()
            }

            do {
                let goals = try self.context.fetch(self.fetchRequest)
                observer.onNext(goals)
                observer.onCompleted()
            } catch {
                observer.onError(CoreDataProviderError.fetchFailure)
            }
            return Disposables.create()
        }
    }

    // fetchGoals: fetch Goalables from Core Data
    //
    public func deleteGoals() -> Observable<Void> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                observer.onError(CoreDataProviderError.createFailure)
                return Disposables.create()
            }

            do {
                try self.context.execute(self.deleteRequest)
                try self.context.save()
                observer.onNext(())
                observer.onCompleted()
            } catch {
                observer.onError(CoreDataProviderError.deleteFailure)
            }
            return Disposables.create()
        }
    }
}
