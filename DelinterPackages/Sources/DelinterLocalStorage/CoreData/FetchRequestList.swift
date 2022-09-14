//
//  File.swift
//  
//
//  Created by Rachel Schneebaum on 9/12/22.
//

import CoreData
import SwiftUI

/// Generic list that can filter and display managed objects via a fetch request.
struct FetchRequestList<Model: NSManagedObject, Content: View>: View {
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
