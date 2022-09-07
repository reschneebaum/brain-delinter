//
//  MockDataStore.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/27/22.
//

import Combine
import CoreData

/// Inspired by [this gist](https://gist.github.com/rpapallas/b7dc2f32769a369425c35a85b86d13ad)
public final class MockDataStore: ObservableObject, LocalDataStoring {
    var temporaryCache: [String] = []
    
    public init(with items: [ListItem]? = nil) {
        if let items {
            temporaryCache = items.map(\.text)
        }
    }
    
    public func save() {
        // no-op
    }
    
    public func addItem(_ text: String) {
        temporaryCache.append(text)
    }
    
    public func updateItem(_ item: ListItem) {
        // no-op (yet)
    }
    
    public func clearAllItems() {
        temporaryCache.removeAll()
    }
}
