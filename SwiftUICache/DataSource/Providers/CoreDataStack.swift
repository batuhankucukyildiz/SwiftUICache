//
//  CoreDataStack.swift
//  SwiftUICache
//
//  Created by Batuhan Küçükyıldız on 3.05.2024.
//

import Foundation
import CoreData
 

final class CoreDataStack {
    static let shared = CoreDataStack() // Singleton Pattern
    private let persistentContinerName = "Cache"
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: persistentContinerName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Failed to load: \(error), \(error.userInfo)")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
}

extension CoreDataStack {
    func saveContext() {
        guard viewContext.hasChanges else { return }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            print("Save Error: \(nsError)")
        }
    }
    
    func fetch<T: NSManagedObject>(_ request: NSFetchRequest<T>) -> [T] {
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
}
