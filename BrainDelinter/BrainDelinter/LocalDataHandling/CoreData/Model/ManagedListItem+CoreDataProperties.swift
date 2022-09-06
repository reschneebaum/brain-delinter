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
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedListItem> {
        .init(entityName: "ManagedListItem")
    }

    @NSManaged public var dateAdded: Date?
    @NSManaged public var dateCompleted: Date?
    @NSManaged public var id: String?
    @NSManaged public var isComplete: Bool
    @NSManaged public var text: String?

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
