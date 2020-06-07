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
        container.loadPersistentStores { (storeDescription, error) in
            if let err = error{
                fatalError("Loading of store failed: \(err)")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()

    public func createGoals(goalables: [Goalable], _ completion: ((Result<[Goalable], Error>) -> ())?) {
        rCreateGoal(goalables) { error in
            if let error = error {
                completion?(.failure(error))
            } else {
                completion?(.success(goalables))
            }
        }
    }

    // Recursive approach.
    // Ideally replace with PromiseKit, RxSwift or self-build Promise library.
    //
    func rCreateGoal(_ goalables: [Goalable], _ completion: @escaping (Error?) -> ()) {
        createGoal(goalable: goalables.last!) { [weak self] res in
            switch res {
            case .success(let goal):
                if goalables.count > 1 {
                    self?.rCreateGoal(goalables.dropLast(), completion)
                } else {
                    completion(nil)
                }
            case .failure(let error):
                completion(error)
            }
        }
    }

    public func createGoal(goalable: Goalable, _ completion: ((Result<Goalable, Error>) -> ())?) {
        let context = self.persistentContainer.viewContext

        guard let goal = NSEntityDescription.insertNewObject(forEntityName: self.goalEntityName, into: context) as? CDGoal else {
            completion?(.failure(CoreDataProviderError.createFailure))
            return
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
            completion?(.failure(CoreDataProviderError.createFailure))
            return
        }
        completion?(.success(goal))
    }

    public func fetchGoals(_ completion: (Result<[Goalable], Error>) -> ()) {
        let context = self.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<CDGoal>(entityName: self.goalEntityName)

        do {
            let goals = try context.fetch(fetchRequest)
            completion(.success(goals))
        } catch {
            completion(.failure(CoreDataProviderError.fetchFailure))
        }
    }
}
