//
//  FilteredList.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 9/5/22.
//

import CoreData
import SwiftUI

public struct FilteredList<Content: View>: View {
    private var predicate: NSPredicate?
    private var sortDescriptors: [NSSortDescriptor]
    private var itemContent: (ListItem) -> Content

    public var body: some View {
        FilterableList(predicate: predicate, sortDescriptors: sortDescriptors) { (listItem: ManagedListItem) in
//            ListItemView(item: listItem)
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
        sortDescriptors = [
            .init(.init(\ManagedListItem.isComplete)),
            .init(.init(\ManagedListItem.dateAdded))
        ]
        itemContent = content
    }
}

/// Generic list that can filter and display managed objects via a fetch request.
private struct FilterableList<Model: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<Model>
    let content: (Model) -> Content
    
    var body: some View {
        if !fetchRequest.isEmpty {
            ForEach(fetchRequest, id: \.self) {
                content($0)
            }
        }
    }
    
    init(
        predicate: NSPredicate?,
        sortDescriptors: [NSSortDescriptor],
        @ViewBuilder content: @escaping (Model) -> Content
    ) {
        _fetchRequest = .init(sortDescriptors: sortDescriptors, predicate: predicate)
        self.content = content
    }
}
