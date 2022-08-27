//
//  ListItem+CoreData.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/27/22.
//

import CoreData
import Foundation

extension ListItem {
    init(_ item: ManagedListItem) {
        self.init(
            id: item.id ?? UUID().uuidString,
            text: item.text ?? "",
            isComplete: item.isComplete,
            dateAdded: item.dateAdded ?? .now,
            dateCompleted: item.dateCompleted
        )
    }
    
    @discardableResult
    func asManagedObject(in context: NSManagedObjectContext) -> ManagedListItem {
        let item = ManagedListItem(context: context)
        item.id = id
        item.text = text
        item.isComplete = isComplete
        item.dateAdded = dateAdded
        if isComplete {
            item.dateCompleted = dateCompleted ?? .now
        }
        return item
    }
}
