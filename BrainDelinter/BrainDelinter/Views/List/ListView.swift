//
//  ListView.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/18/22.
//

import SwiftUI

struct ListView: View {
    @State private var newItemText = ""
    @State private var items: [ListItem] = []
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: Padding.medium.rawValue, pinnedViews: .sectionHeaders) {
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
            
        }
        .padding(.horizontal, Padding.medium.rawValue)
        .background(Color.blue.opacity(0.2))
        .navigationTitle("🧼 🧠")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var header: some View {
        VStack(spacing: Padding.medium.rawValue) {
            Text(Localized.List.title)
            
            Text(Localized.List.description)
                .font(.Rounded.Light.body)
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
                        .strokeBorder(lineWidth: 2)
                        .foregroundColor(.accentColor.opacity(0.7))
                        .foregroundColor(.white)
            )
        }
        .padding(.vertical, Padding.small.rawValue)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }
    }
}
