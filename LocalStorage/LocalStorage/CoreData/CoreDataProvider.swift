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
    private let identifier: String = "com.illuminati1911.activitygoals.LocalStorage"
    private let model: String = "CoreDataModel"
    private let goalEntityName = "CDGoal"

    public init() {}

    // persistentContainer lazy init
    // -----------------------------
    // Force unwraps are used here as LocalStorage is considered to be mission
    // critical component for the application.
    //
    private lazy var persistentContainer: NSPersistentContainer = {
        let messageKitBundle = Bundle(identifier: self.identifier)
        let modelURL = messageKitBundle!.url(forResource: self.model, withExtension: "momd")!
        let managedObjectModel =  NSManagedObjectModel(contentsOf: modelURL)

        let container = NSPersistentContainer(name: self.model, managedObjectModel: managedObjectModel!)
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Loading of store failed: \(error)")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()

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

                do {
                    try context.save()
                } catch {
                    observer.onError(CoreDataProviderError.createFailure)
                    return Disposables.create()
                }
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
