//
//  FilteredItemsList.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 9/5/22.
//

import CoreData
import SwiftUI

public struct FilteredItemsList<Content: View>: View {
    private var predicate: NSPredicate?
    private var sortDescriptors: [NSSortDescriptor]
    private var itemContent: (ListItem) -> Content

    public var body: some View {
        FetchRequestList(predicate: predicate, sortDescriptors: sortDescriptors) { (listItem: ManagedListItem) in
            itemContent(.init(listItem))
            
            Color.gray.opacity(0.7)
                .frame(height: 1)
        }
    }
    
    /// Sorts list items by complete status (if shown at all, completed items are always at the end of the list) and date added;
    /// if `showComplete` is `false`, also hides items where `isComplete == true`
    public init(showComplete: Bool = true, @ViewBuilder content: @escaping (ListItem) -> Content) {
        if !showComplete {
            predicate = .init(format: "isComplete == %@", NSNumber(false))
        }
        let descriptors: [SortDescriptor<ManagedListItem>] = [.init(\.isComplete), .init(\.dateAdded)]
        sortDescriptors = descriptors.map { .init($0) }
        itemContent = content
    }
}
