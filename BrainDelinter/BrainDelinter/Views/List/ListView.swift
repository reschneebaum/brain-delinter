//
//  ListView.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/18/22.
//

import SwiftUI
import DelinterLocalStorage

struct ListView<DataStore: LocalDataStoring>: View {
    @Environment(\.userDefaults) var defaults
    @EnvironmentObject var dataStore: DataStore
    @State private var newItemText = ""
    @State private var showCompleted = true
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: Padding.medium.rawValue, pinnedViews: .sectionHeaders) {
                Section {
                    Text(Localized.List.description)
                        .multilineTextAlignment(.center)
                        .font(.Rounded.Medium.body)
                        .padding(.horizontal, Padding.medium.rawValue)
                }
                
                Section {
                    FilteredList(showComplete: showCompleted) { item in
                        ListItemView(
                            item: .init { item } set: { dataStore.updateItem($0) }
                        )
                    }
                    .onReceive(defaults.publisher(for: \.showCompleted)) {
                        showCompleted = $0
                    }
                } header: {
                    stickyHeader
                }
            }
            .headerProminence(.increased)
        }
        .padding(.horizontal, Padding.medium.rawValue)
        .background(Color.blue.opacity(0.2))
        .navigationTitle(Localized.List.title)
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            dataStore.save()
        }
    }
    
    private var stickyHeader: some View {
        TextField(Localized.List.textFieldLabel, text: $newItemText)
            .textInputAutocapitalization(.never)
            .submitLabel(.done)
            .onSubmit {
                guard !newItemText.isEmpty else { return }
                dataStore.addItem(newItemText)
                newItemText = ""
            }
            .accentColor(.alwaysBlack)
            .foregroundColor(.alwaysBlack)
            .padding(.all, Padding.medium.rawValue)
            .background(
                RoundedRectangle(cornerRadius: Padding.medium.rawValue)
                    .strokeBorder(lineWidth: 2)
                    .foregroundColor(.accentColor.opacity(0.7))
                    .shadow(color: .white.opacity(0.8), radius: 4, x: 0, y: 4)
            )
            .background(
                RoundedRectangle(cornerRadius: Padding.medium.rawValue)
                    .foregroundColor(.lightBlueOpaque)
            )
            .padding(.bottom, Padding.small.rawValue)
        }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView<MockDataStore>()
        }
        .environment(\.userDefaults, .mocked)
        .environmentObject(MockDataStore())
    }
}
