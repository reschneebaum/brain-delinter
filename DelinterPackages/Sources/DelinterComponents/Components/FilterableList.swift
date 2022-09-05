//
//  FilterableList.swift
//  
//
//  Created by Rachel Schneebaum on 9/5/22.
//

import CoreData
import SwiftUI

public struct FilterableList<Model: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<Model>
    let content: (Model) -> Content
    
    public var body: some View {
        if !fetchRequest.isEmpty {
            ForEach(fetchRequest, id: \.self) {
                content($0)
            }
        }
    }
    
    public init(
        predicate: NSPredicate?,
        sortDescriptors: [NSSortDescriptor],
        @ViewBuilder content: @escaping (Model) -> Content
    ) {
        _fetchRequest = .init(sortDescriptors: sortDescriptors, predicate: predicate)
        self.content = content
    }
    
    public init(
        filterByKey key: String,
        forValue value: String,
        sortDescriptors: [NSSortDescriptor] = [],
        @ViewBuilder content: @escaping (Model) -> Content
    ) {
        self.init(predicate: .init(format: "%K == %@", key, value), sortDescriptors: sortDescriptors, content: content)
    }
}
