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
            LazyVStack(alignment: .center, spacing: Padding.medium.rawValue, pinnedViews: .sectionHeaders) {
                Section {
                    if !items.isEmpty {
                        ForEach($items) { $item in
                            ListItemView(item: $item)
                        }
                    }
                } header: {
                    header
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, Padding.medium.rawValue)
        .navigationTitle("🧼 🧠")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var header: some View {
        VStack(spacing: 12) {
            Text(Localized.List.title)
            
            Text(Localized.List.description)
                .font(.system(size: 14, weight: .light, design: .rounded))
                .padding(.horizontal, Padding.xSmall.rawValue)
            
            TextField(Localized.List.textFieldLabel, text: $newItemText)
                .textInputAutocapitalization(.never)
                .submitLabel(.done)
                .onSubmit {
                    guard !newItemText.isEmpty else { return }
                    items.append(.init(description: newItemText))
                    newItemText = ""
                }
                .padding(.all, Padding.medium.rawValue)
                .background(
                    RoundedRectangle(cornerRadius: Padding.medium.rawValue)
                        .strokeBorder(lineWidth: 1.2)
                        .foregroundColor(.blue.opacity(0.6))
                        .foregroundColor(.white)
            )
        }
        .padding(.vertical, Padding.small.rawValue)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
