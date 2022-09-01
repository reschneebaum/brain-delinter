//
//  LocalDataStore.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/27/22.
//

import CoreData
import SwiftUI

protocol DataStoreInterface: ObservableObject {
    var managedObjectContext: NSManagedObjectContext { get }
    func save()
    func addItem(_ text: String)
    func clearAllItems()
}

final class LocalDataStore: DataStoreInterface {
    private let container: NSPersistentContainer
    var managedObjectContext: NSManagedObjectContext {
        container.viewContext
    }
    
    init(containerName: String? = nil) {
        container = .init(name: containerName ?? "DataModel")
        
        container.loadPersistentStores { [weak self] _, error in
            if let error = error {
                print("core data load error: \(error.localizedDescription)")
            }
            // Overwrite the existing object's property values with those of the new object
            self?.managedObjectContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
    
    func save() {
        try? managedObjectContext.save()
        objectWillChange.send()
    }
    
    func addItem(_ text: String) {
        ManagedListItem.createNewItem(with: text, in: managedObjectContext)
    }
    
    func clearAllItems() {
        let allItems = getStoredItems()
        deleteItems(allItems)
    }
}

// MARK: Private Extension

private extension LocalDataStore {
    func getStoredItems() -> [ManagedListItem] {
        let fetchRequest = ManagedListItem.fetchRequest()
        
        do {
            return try managedObjectContext.fetch(fetchRequest)
        } catch {
            print("error fetching list items: \(error.localizedDescription)")
            return []
        }
    }
    
    func deleteItems(_ items: [ManagedListItem]) {
        items.forEach {
            managedObjectContext.delete($0)
        }
    }
}

// TODO: The method in this extension is not needed/used since we're accessing managed objects + context directly

extension LocalDataStore {
    /// I need to decide whether to a) try wrapping core data again (ideally in a separate package) _or_ b) remove
    /// the `ListItem` model — and this extension — from the workspace entirely.
    func persistLocalItems(_ items: [ListItem]? = nil) {
        /*
        let currentItems = getStoredItems()
        let newItems = items ?? []
        
        newItems.forEach { newItem in
            if let currentItem = currentItems.first(where: { $0.id == newItem.id }) {
                if currentItem.text == newItem.text && currentItem.isComplete == newItem.isComplete {
                    // If there are no changes, nothing needs to be updated in core data.
                    return
                }
                // Note: id and dateAdded shouldn't change, don't need to be updated.
                currentItem.text = newItem.text
                currentItem.isComplete = newItem.isComplete
                currentItem.dateCompleted = newItem.dateCompleted
            } else {
                // Add a new item to our moc
                newItem.asManagedObject(in: container.viewContext)
            }
        }
        
        try? container.viewContext.save()
         */
    }
}
