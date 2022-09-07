//
//  LocalDataStore.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/27/22.
//

import CoreData
import SwiftUI

public protocol LocalDataStoring: ObservableObject {
    func save()
    func addItem(_ text: String)
    func updateItem( _ item: ListItem)
    func clearAllItems()
}

public final class LocalDataStore: LocalDataStoring {
    private let container: PersistentContainer
    public var context: NSManagedObjectContext {
        container.viewContext
    }
    
    public init() {
        container = .init()
    }
    
    public func save() {
        guard context.hasChanges else { return }
        try? context.save()
    }
    
    public func addItem(_ text: String) {
        ManagedListItem.createNewItem(with: text, in: context)
    }
    
    public func updateItem(_ item: ListItem) {
        guard let managedItem = storedItem(with: item.id),
              managedItem.isComplete != item.isComplete else { return }
        
        managedItem.isComplete = item.isComplete
        managedItem.dateCompleted = item.isComplete ? Date.now : nil
    }
    
    public func clearAllItems() {
        let allItems = getStoredItems()
        deleteItems(allItems)
        save()
    }
}

// MARK: Private Extension

private extension LocalDataStore {
    func getStoredItems() -> [ManagedListItem] {
        let fetchRequest = ManagedListItem.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("error fetching list items: \(error.localizedDescription)")
            return []
        }
    }
    
    // TODO: Is there a way to refactor this/combine it with the almost identical `getStoredItems` method above?
    func storedItem(with id: String) -> ManagedListItem? {
        let fetchRequest = ManagedListItem.itemFetchRequest(id: id)
        
        do {
            return try context.fetch(fetchRequest).first
        } catch {
            print("error fetching list items: \(error.localizedDescription)")
            return nil
        }
    }
    
    func deleteItems(_ items: [ManagedListItem]) {
        guard !items.isEmpty else { return }
        
        items.forEach {
            context.delete($0)
        }
    }
}

// TODO: The method in this extension is not needed/used since we're accessing managed objects + context directly

/*
extension LocalDataStore {
    /// I need to decide whether to a) try wrapping core data again (ideally in a separate package) _or_ b) remove
    /// the `ListItem` model — and this extension — from the workspace entirely.
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
}
 */
