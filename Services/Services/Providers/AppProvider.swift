//
//  AppProvider.swift
//  Services
//
//  Created by Ville Välimaa on 2020/6/8.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import HealthKit
import CoreData
import Networking
import LocalStorage

public class AppProvider: MainProvider {
    public var dataProvider: DataProvider
    public var activityProvider: ActivityProvider

    init() {
        self.activityProvider = HealthKitActivityProvider(activityService: HKHealthStore())
        self.dataProvider = RemoteWithLocalDataProvider(
            remote: APIService(),
            local: CoreDataProvider(container: AppProvider.getPersistentContainer()))
    }

    public static func getApplicationProvider() -> MainProvider {
        return AppProvider()
    }

    // persistentContainer lazy init
    // -----------------------------
    // Force unwraps are used here as LocalStorage is considered to be mission
    // critical component for the application.
    //
    private static func getPersistentContainer() -> NSPersistentContainer {
        let identifier = "com.illuminati1911.activitygoals.LocalStorage"
        let model = "CoreDataModel"
        let localStorageBundle = Bundle(identifier: identifier)
        let modelURL = localStorageBundle!.url(forResource: model, withExtension: "momd")!
        let managedObjectModel =  NSManagedObjectModel(contentsOf: modelURL)

        let container = NSPersistentContainer(name: model, managedObjectModel: managedObjectModel!)
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Loading of store failed: \(error)")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }
}
