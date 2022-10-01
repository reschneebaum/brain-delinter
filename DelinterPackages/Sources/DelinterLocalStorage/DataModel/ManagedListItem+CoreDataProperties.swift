//
//  ManagedListItem+CoreDataProperties.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 9/6/22.
//
//

import CoreData
import Foundation

extension ManagedListItem {
    static let entityName = "ManagedListItem"
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<ManagedListItem> {
        .init(entityName: Self.entityName)
    }
    
    @nonobjc class func itemFetchRequest(id: String) -> NSFetchRequest<ManagedListItem> {
        let request: NSFetchRequest<ManagedListItem> = .init(entityName: Self.entityName)
        request.predicate = .init(format: "id == %@", id)
        return request
    }

    @NSManaged var dateAdded: Date?
    @NSManaged var dateCompleted: Date?
    @NSManaged var id: String?
    @NSManaged var isComplete: Bool
    @NSManaged var text: String?

    override var description: String {
        Self.entityName
    }
}

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
