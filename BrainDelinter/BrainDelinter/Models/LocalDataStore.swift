//
//  LocalDataStore.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/27/22.
//

import CoreData
import Foundation
import SwiftUI

class LocalDataStore: ObservableObject {
    let container = NSPersistentContainer(name: "DataModel")
    
    init() {
        container.loadPersistentStores { [weak self] description, error in
            if let error = error {
                print("core data load error: \(error.localizedDescription)")
            }
            
            // Overwrite the existing object's property values with those of the new object
            self?.container.viewContext.mergePolicy = NSMergePolicy.overwrite
        }
    }
    
    func getStoredItems() -> [ManagedListItem] {
        let fetchRequest = ManagedListItem.fetchRequest()
        
        do {
            return try container.viewContext.fetch(fetchRequest)
        } catch {
            print("error fetching list items: \(error.localizedDescription)")
            return []
        }
    }
    
    func saveItemsLocally(_ items: [ListItem]) {
        let currentItems = getStoredItems()
        items.forEach { newItem in
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
