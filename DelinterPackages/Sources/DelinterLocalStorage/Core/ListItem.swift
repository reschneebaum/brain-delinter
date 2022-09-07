//
//  ListItem.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/19/22.
//

import Foundation

public struct ListItem {
    public var id = UUID().uuidString
    public let text: String
    public var isComplete = false
    public var dateAdded: Date = .now
    public var dateCompleted: Date?
}

// MARK: - Extensions

// Core Data helper

extension ListItem {
    init(_ managedItem: ManagedListItem) {
        id = managedItem.wrappedID
        text = managedItem.wrappedText
        isComplete = managedItem.isComplete
        dateAdded = managedItem.createdDate
        dateCompleted = managedItem.dateCompleted
    }
}

// MARK: Codable

extension ListItem: Codable {}

// MARK: Identifiable

extension ListItem: Identifiable {}

// MARK: Hashable

extension ListItem: Hashable {}

// MARK: Previews

#if DEBUG
public extension ListItem {
    static var mocked: Self {
        .init(text: "Test item")
    }
}
#endif
