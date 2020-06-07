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
            return "Could not create model"
        case .fetchFailure:
            return "Could fetch model(s)"
        case .unknown:
            return "Unknown error"
        }
    }
}

public class CoreDataProvider: LocalStorageProtocol {
    private let identifier: String = "com.illuminati1911.activitygoals.LocalStorage"
    private let model: String = "CoreDataModel"
    private let goalEntityName = "CDGoal"

    public init() {}

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

    public func createGoals(goalables: [Goalable]) -> Observable<[Goalable]> {
        return Observable.combineLatest(goalables.map { createGoal(goalable: $0) })
    }

    public func createGoal(goalable: Goalable) -> Observable<Goalable> {
        return Observable.create { observer in
            let context = self.persistentContainer.viewContext
            guard let goal = NSEntityDescription.insertNewObject(forEntityName: self.goalEntityName, into: context) as? CDGoal else {
                observer.onError(CoreDataProviderError.createFailure)
                return Disposables.create()
            }

            goal.id = goalable.asGoal().id
            goal.title = goalable.asGoal().title
            goal.desc = goalable.asGoal().description
            goal.type = goalable.asGoal().type
            goal.goal = Int64(goalable.asGoal().goal)
            goal.trophy = goalable.asGoal().reward.trophy
            goal.points = Int64(goalable.asGoal().reward.points)

            do {
                try context.save()
            } catch {
                observer.onError(CoreDataProviderError.createFailure)
                return Disposables.create()
            }
            observer.onNext(goal)
            return Disposables.create()
        }
    }

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
