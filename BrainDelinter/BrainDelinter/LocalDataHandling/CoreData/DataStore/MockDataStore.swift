//
//  MockDataStore.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/27/22.
//

import Combine
import CoreData

/// Inspired by [this gist](https://gist.github.com/rpapallas/b7dc2f32769a369425c35a85b86d13ad)
final class MockDataStore: ObservableObject, DataStoreInterface {
    var temporaryCache: [String] = []
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
        return context
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel? = {
        .mergedModel(from: [.main])
    }()
    
    /// Redirects the `NSPersistentStoreCoordinator` to memory.
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        guard let managedObjectModel = managedObjectModel else {
            return nil
        }
        var coordinator: NSPersistentStoreCoordinator? = .init(managedObjectModel: managedObjectModel)
        
        do {
            try coordinator?.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil)
        } catch {
            coordinator = nil
        }
        
        return coordinator
    }()
    
    func save() {
        // no-op
    }
    
    func addItem(_ text: String) {
        temporaryCache.append(text)
    }
    
    func clearAllItems() {
        temporaryCache.removeAll()
    }
}
