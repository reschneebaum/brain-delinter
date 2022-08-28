//
//  LocalDataStore.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/27/22.
//

import CoreData
import SwiftUI

class LocalDataStore: ObservableObject {
    let container: NSPersistentContainer
    
    init(containerName: String? = nil) {
        container = .init(name: containerName ?? "DataModel")
        
        container.loadPersistentStores { [weak self] _, error in
            if let error = error {
                print("core data load error: \(error.localizedDescription)")
            }
            // Overwrite the existing object's property values with those of the new object
            self?.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
    
    func save() {
        try? container.viewContext.save()
    }
}

// NOTE: The following methods are not needed/used since we're accessing managed objects and
// our moc directly. If we want to wrap core data and use the old `ListItem` throughout, uncomment:
/*
extension LocalDataStore {
    func getStoredItems() -> [ManagedListItem] {
        let fetchRequest = ManagedListItem.fetchRequest()
        
        do {
            return try container.viewContext.fetch(fetchRequest)
        } catch {
            print("error fetching list items: \(error.localizedDescription)")
            return []
        }
    }
    
    func persistLocalItems(_ items: [ListItem]? = nil) {
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
    }
    
    func deleteItem(_ item: ManagedListItem) {
        container.viewContext.delete(item)
        try? container.viewContext.save()
    }
    
    func deleteItems(_ items: [ManagedListItem]) {
        items.forEach {
            container.viewContext.delete($0)
        }
        try? container.viewContext.save()
    }
}
*/
