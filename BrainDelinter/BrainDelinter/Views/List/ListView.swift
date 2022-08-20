//
//  ListView.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/18/22.
//

import SwiftUI

// TODO: localize strings + pull out constants

struct ListView: View {
    @State private var newItemText = ""
    @State private var items: [Item] = []
    
    var body: some View {
        VStack {
            LazyVStack(alignment: .center, spacing: 12, pinnedViews: .sectionHeaders) {
                Section {
                    if !items.isEmpty {
                        ForEach($items) { $item in
                            ItemView(item: $item)
                        }
                    }
                } header: {
                    header
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 12)
        .navigationTitle("🧼 🧠")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var header: some View {
        VStack(spacing: 12) {
            Text("get the lint out!")
            
            Text("add it to the list so you don't have to think about it anymore")
                .font(.system(size: 14, weight: .light, design: .rounded))
                .padding(.horizontal, 4)
            
            TextField("add some lint", text: $newItemText)
                .textInputAutocapitalization(.never)
                .submitLabel(.done)
                .onSubmit {
                    guard !newItemText.isEmpty else { return }
                    items.append(.init(description: newItemText))
                    newItemText = ""
                }
                .padding(.all, 12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(lineWidth: 1.2)
                        .foregroundColor(.blue.opacity(0.6))
                        .foregroundColor(.white)
                        
            )
        }
        .padding(.vertical, 8)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
