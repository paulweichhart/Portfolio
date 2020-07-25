//
//  CoreDataStack.swift
//  Portfolio
//
//  Created by Paul Weichhart on 06.06.20.
//  Copyright © 2020 Paul Weichhart. All rights reserved.
//

import CoreData
import Foundation

final class CoreDataStack {
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private(set) lazy var persistentContainer: NSPersistentCloudKitContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentCloudKitContainer(name: "Portfolio")
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Symbols
    
    func fetchSymbols(search: String = "") -> [CoreDataSymbol] {
        let request = NSFetchRequest<CoreDataSymbol>(entityName: CoreDataSymbol.entityName)
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        if !search.isEmpty {
            request.predicate = NSPredicate(format: "id contains[cd] %@ OR title contains[cd] %@", search, search)
        }
        let symbols: [CoreDataSymbol]
        do {
            symbols = try context.fetch(request)
            print(symbols.count)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
        return symbols
    }
    
    func deleteSymbols() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: CoreDataSymbol.entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
