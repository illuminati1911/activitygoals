//
//  CoreDataManager.swift
//  LocalStorage
//
//  Created by Ville Välimaa on 2020/6/6.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import CoreData
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

public class CoreDataProvider: CoreDataProviderProtocol {
    private let identifier: String = "com.illuminati1911.activitygoals.LocalStorage"
    private let model: String = "CoreDataModel"
    private let goalEntityName = "CDGoal"

    public init() {}

    private lazy var persistentContainer: NSPersistentContainer = {
        let messageKitBundle = Bundle(identifier: self.identifier)
        let modelURL = messageKitBundle!.url(forResource: self.model, withExtension: "momd")!
        let managedObjectModel =  NSManagedObjectModel(contentsOf: modelURL)

        let container = NSPersistentContainer(name: self.model, managedObjectModel: managedObjectModel!)
        container.loadPersistentStores { (storeDescription, error) in
            if let err = error{
                fatalError("Loading of store failed: \(err)")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()

    public func createGoal(id: String, title: String, desc: String, type: String, gl: Int64, trophy: String, points: Int64) -> Observable<Void> {
        return Observable.create { [weak self] observer -> Disposable in
            guard let self = self else {
                observer.onError(CoreDataProviderError.unknown)
                return Disposables.create()
            }
            let context = self.persistentContainer.viewContext

            guard let goal = NSEntityDescription.insertNewObject(forEntityName: self.goalEntityName, into: context) as? CDGoal else {
                observer.onError(CoreDataProviderError.createFailure)
                return Disposables.create()
            }
            goal.id = id
            goal.title = title
            goal.desc = desc
            goal.type = type
            goal.goal = gl
            goal.trophy = trophy
            goal.points = points

            do {
                try context.save()
            } catch {
                observer.onError(CoreDataProviderError.createFailure)
                return Disposables.create()
            }
            observer.onNext(())
            return Disposables.create()
        }
    }

    public func fetchGoals() -> Observable<[CDGoal]> {
        return Observable.create { [weak self] observer -> Disposable in
            guard let self = self else {
                observer.onError(CoreDataProviderError.unknown)
                return Disposables.create()
            }
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
