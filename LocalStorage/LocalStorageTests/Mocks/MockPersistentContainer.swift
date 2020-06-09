//
//  MockPersistentContainer.swift
//  LocalStorageTests
//
//  Created by Ville Välimaa on 2020/6/9.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import CoreData

class MockPersistentContainer {
    static func getMockPersistentContainer() -> NSPersistentContainer {
        let identifier = "com.illuminati1911.activitygoals.LocalStorage"
        let model = "CoreDataModel"
        let localStorageBundle = Bundle(identifier: identifier)
        let modelURL = localStorageBundle!.url(forResource: model, withExtension: "momd")!
        let managedObjectModel =  NSManagedObjectModel(contentsOf: modelURL)!
        let container = NSPersistentContainer(name: model, managedObjectModel: managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false

        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )

            // Check if creating container wrong
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        return container
    }
}
