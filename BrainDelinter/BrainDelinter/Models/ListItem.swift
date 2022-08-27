//
//  ListItem.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/19/22.
//

import Foundation

struct ListItem {
    var id = UUID().uuidString
    let text: String
    var isComplete = false
    var dateAdded: Date = .now
    var dateCompleted: Date?
}

// MARK: - Extensions

// MARK: Codable

extension ListItem: Codable {}

// MARK: Identifiable

extension ListItem: Identifiable {}

// MARK: Hashable

extension ListItem: Hashable {}

// MARK: Previews

#if DEBUG
extension ListItem {
    static var mocked: Self {
        .init(text: "Test item")
    }
}
#endif
