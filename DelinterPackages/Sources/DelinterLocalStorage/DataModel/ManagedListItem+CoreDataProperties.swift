//
//  ManagedListItem+CoreDataProperties.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 9/6/22.
//
//

import Foundation
import CoreData


extension ManagedListItem {
    @nonobjc class func fetchRequest() -> NSFetchRequest<ManagedListItem> {
        .init(entityName: "ManagedListItem")
    }

    @NSManaged var dateAdded: Date?
    @NSManaged var dateCompleted: Date?
    @NSManaged var id: String?
    @NSManaged var isComplete: Bool
    @NSManaged var text: String?

    override var description: String {
        "ManagedListItem"
    }
}

// MARK: Identifiable

extension ManagedListItem: Identifiable {}

// MARK: Helpers

extension ManagedListItem {
    var createdDate: Date {
        get { dateAdded ?? .now }
        set { dateAdded = newValue }
    }
    
    var wrappedID: String {
        get { id ?? UUID().uuidString }
        set { id = newValue }
    }
    
    var wrappedText: String {
        get { text ?? "" }
        set { text = newValue }
    }
}
