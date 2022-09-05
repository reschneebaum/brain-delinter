//
//  FilteredList.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 9/5/22.
//

import CoreData
import SwiftUI
import DelinterComponents

struct FilteredList: View {
    private var predicate: NSPredicate?
    private var sortDescriptors: [NSSortDescriptor]

    var body: some View {
        FilterableList(predicate: predicate, sortDescriptors: sortDescriptors) { (listItem: ManagedListItem) in
            ListItemView(item: listItem)
            
            Color.gray.opacity(0.7)
                .frame(height: 1)
        }
    }
    
    /// Sorts list items by complete status (if shown at all, completed items are always at the end of the list) and date added;
    /// if `showComplete` is `false`, also hides items where `isComplete == true`
    init(showComplete: Bool = true) {
        if !showComplete {
            predicate = .init(format: "isComplete == %@", NSNumber(false))
        }
        sortDescriptors = [
            .init(.init(\ManagedListItem.isComplete)),
            .init(.init(\ManagedListItem.dateAdded))
        ]
    }
}
