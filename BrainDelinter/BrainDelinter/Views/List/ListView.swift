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
                Section { topContent }
                
                Section {
                    FilteredList(showComplete: showCompleted) {
                        ListItemView(item: .constant($0))
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
            .padding(.all, Padding.medium.rawValue)
            .background(
                RoundedRectangle(cornerRadius: Padding.medium.rawValue)
                    .strokeBorder(lineWidth: 2)
                    .foregroundColor(.accentColor.opacity(0.7))
                    .shadow(color: .white.opacity(0.7), radius: 4, x: 0, y: 4)
        )
        .padding(.vertical, Padding.small.rawValue)
        .backgroundColorOnWhite(.blue.opacity(0.2))
    }
    
    @ViewBuilder
    private var topContent: some View {
        Text(Localized.List.subheader)
            .font(.Rounded.Light.subheader)
        
        Text(Localized.List.description)
            .font(.Rounded.bodyS)
            .padding(.horizontal, Padding.xSmall.rawValue)
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
