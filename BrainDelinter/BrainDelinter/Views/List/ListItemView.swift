//
//  ListItemView.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/19/22.
//

import SwiftUI
import DelinterComponents

struct ListItemView: View {
    @Binding var item: ListItem
    
    var body: some View {
        VStack {
            CheckboxToggle(isOn: $item.done) {
                Text(item.description)
                    .strikethrough(item.done, color: .accentColor)
            }
            
            Color.accentColor
                .opacity(0.7)
                .frame(height: 1)
        }
        .padding(.horizontal, Padding.small.rawValue)
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewBody()
    }
    
    struct PreviewBody: View {
        @State private var item: ListItem = .mocked
        
        var body: some View {
            ListItemView(item: $item)
        }
    }
}
