//
//  Item.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/19/22.
//

import Foundation

struct Item {
    var id = UUID().uuidString
    let description: String
    var done = false
}

// MARK: - Extensions

// MARK: Codable

extension Item: Codable {}

// MARK: Identifiable

extension Item: Identifiable {}

// MARK: Hashable

extension Item: Hashable {}

// MARK: Previews

#if DEBUG
extension Item {
    static var mocked: Self {
        .init(description: "Test item")
    }
}
#endif
