//
//  ItemView.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/19/22.
//

import SwiftUI
import DelinterComponents

struct ItemView: View {
    @Binding var item: Item
    
    var body: some View {
        VStack {
            CheckboxToggle(isOn: $item.done) {
                Text(item.description)
                    .strikethrough(item.done, color: .accentColor)
            }
            
            Color.gray
                .opacity(0.7)
                .frame(height: 1)
        }
        .padding(.horizontal, 8)
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewBody()
    }
    
    struct PreviewBody: View {
        @State private var item: Item = .mocked
        
        var body: some View {
            ItemView(item: $item)
        }
    }
}
