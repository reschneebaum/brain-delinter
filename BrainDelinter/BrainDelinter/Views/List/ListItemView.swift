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
            CheckboxToggle(isOn: $item.isComplete) {
                checkboxContent
            }
            
            Color.accentColor
                .opacity(0.7)
                .frame(height: 1)
        }
        .padding(.horizontal, Padding.small.rawValue)
    }
}

private extension ListItemView {
    var checkboxContent: some View {
        ZStack {
            HStack {
                Text(item.text)
                    .font(item.isComplete ? .Italic.body : .Rounded.Light.body)
                    .fontWeight(item.isComplete ? .light : .medium)
                
                Spacer()
            }
            
            Rectangle()
                .frame(height: 1.2)
                .foregroundColor(item.isComplete ? .accentColor : .clear)
                .animation(.default, value: item.isComplete)
                .transition(.slide)
        }
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
