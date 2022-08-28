//
//  ListView.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/18/22.
//

import SwiftUI
import DelinterComponents

struct ListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [.init(\.dateAdded)]) var items: FetchedResults<ManagedListItem>
    @State private var newItemText = ""
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: Padding.medium.rawValue, pinnedViews: .sectionHeaders) {
                Section { topContent }
                
                Section {
                    if !items.isEmpty {
                        ForEach(items) { item in
                            ListItemView(item: item)
                            
                            Color.gray.opacity(0.7)
                                .frame(height: 1)
                        }
                    }
                } header: {
                    stickyHeader
                } footer: {
                    footer
                }
            }
            .headerProminence(.increased)
        }
        .padding(.horizontal, Padding.medium.rawValue)
        .background(Color.blue.opacity(0.2))
        .navigationTitle(Localized.List.title)
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            try? moc.save()
        }
    }
    
    private var stickyHeader: some View {
        TextField(Localized.List.textFieldLabel, text: $newItemText)
            .textInputAutocapitalization(.never)
            .submitLabel(.done)
            .onSubmit {
                guard !newItemText.isEmpty else { return }
                ManagedListItem.createNewItem(with: newItemText, in: moc)
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
    
    private var footer: some View {
        Text("❤️")
            .font(.Italic.footnote)
            .padding()
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }
    }
}
