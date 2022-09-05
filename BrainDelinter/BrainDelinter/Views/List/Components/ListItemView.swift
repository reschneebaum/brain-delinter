//
//  ListItemView.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/19/22.
//

import SwiftUI
import DelinterComponents

struct ListItemView: View {
    @ObservedObject var item: ManagedListItem
    
    var body: some View {
        CheckboxToggle(isOn: $item.isComplete) {
            checkboxContent
        }
        .padding(.horizontal, Padding.small.rawValue)
    }
}

private extension ListItemView {
    var checkboxContent: some View {
        ZStack {
            HStack {
                Text(item.text ?? "")
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
        PreviewBody(item: .mocked)
    }
    
    struct PreviewBody: View {
        @ObservedObject var item: ManagedListItem
        
        var body: some View {
            ListItemView(item: item)
        }
    }
}