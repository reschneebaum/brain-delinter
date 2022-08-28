//
//  ListItem+CoreData.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/27/22.
//

import CoreData
import Foundation

extension ManagedListItem {
    @discardableResult
    static func createNewItem(with text: String, in context: NSManagedObjectContext) -> ManagedListItem {
        let itemData = ListItem(text: text)
        let managedItem = ManagedListItem(context: context)
        managedItem.id = itemData.id
        managedItem.text = itemData.text
        managedItem.isComplete = itemData.isComplete
        managedItem.dateAdded = itemData.dateAdded
        if itemData.isComplete {
            managedItem.dateCompleted = itemData.dateCompleted ?? .now
        }
        return managedItem
    }
}
