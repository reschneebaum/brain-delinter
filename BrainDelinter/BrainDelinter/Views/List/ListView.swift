//
//  ListView.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/18/22.
//

import SwiftUI
import DelinterComponents

struct ListView: View {
    @EnvironmentObject var dataStore: LocalDataStore
    @State private var newItemText = ""
//    @State private var items: [ListItem] = []
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: Padding.medium.rawValue, pinnedViews: .sectionHeaders) {
                Section {
                    if !dataStore.tempItems.isEmpty {
                        ForEach($dataStore.tempItems) { $item in
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
        .navigationTitle(Localized.List.title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if dataStore.tempItems.isEmpty {
                dataStore.tempItems = dataStore.getStoredItems().map { .init($0) }
            }
        }
    }
    
    private var header: some View {
        VStack(spacing: Padding.medium.rawValue) {
            Text(Localized.List.subheader)
                .font(.Rounded.Light.subheader)
            
            TextField(Localized.List.textFieldLabel, text: $newItemText)
                .textInputAutocapitalization(.never)
                .submitLabel(.done)
                .onSubmit {
                    guard !newItemText.isEmpty else { return }
                    dataStore.tempItems.append(.init(text: newItemText))
                    newItemText = ""
                }
                .padding(.all, Padding.medium.rawValue)
                .background(
                    RoundedRectangle(cornerRadius: Padding.medium.rawValue)
                        .strokeBorder(lineWidth: 2)
                        .foregroundColor(.accentColor.opacity(0.7))
                        .foregroundColor(.white)
            )
            
            Text(Localized.List.description)
                .font(.Rounded.Light.body)
                .padding(.horizontal, Padding.xSmall.rawValue)
                .padding(.top, Padding.small.rawValue)
        }
        .padding(.vertical, Padding.small.rawValue)
        .backgroundColorOnWhite(.blue.opacity(0.2))
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }
        .environmentObject(LocalDataStore())
    }
}
