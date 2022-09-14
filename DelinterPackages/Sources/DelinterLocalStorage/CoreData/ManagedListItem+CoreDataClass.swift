//
//  ManagedListItem+CoreDataClass.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 9/6/22.
//
//

import Foundation
import CoreData

@objc(ManagedListItem)
class ManagedListItem: NSManagedObject {
    @discardableResult
    static func createNewItem(with text: String, in context: NSManagedObjectContext) -> ManagedListItem {
        let managedItem = ManagedListItem(context: context)
        managedItem.id = UUID().uuidString
        managedItem.text = text
        managedItem.isComplete = false
        managedItem.dateAdded = .now
        return managedItem
    }
}
