//
//  ListItemView.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/19/22.
//

import SwiftUI
import DelinterComponents
import DelinterLocalStorage

struct ListItemView: View {
    @Binding var item: ListItem
    @State private var isComplete: Bool
    
    var body: some View {
        CheckboxToggle(isOn: $isComplete) {
            checkboxContent
        }
        .padding(.horizontal, Padding.small.rawValue)
        .onChange(of: isComplete) { newValue in
            if newValue != item.isComplete {
                item.isComplete.toggle()
            }
        }
        .onChange(of: item.isComplete) { newValue in
            guard newValue != isComplete else { return }
            withAnimation {
                isComplete.toggle()
            }
        }
    }
    
    init(item: Binding<ListItem>) {
        _item = item
        _isComplete = State(wrappedValue: item.wrappedValue.isComplete)
    }
}

private extension ListItemView {
    var checkboxContent: some View {
        ZStack {
            HStack {
                Text(item.text)
                    .font(isComplete ? .Italic.body : .Rounded.Light.body)
                    .fontWeight(isComplete ? .light : .medium)
                
                Spacer()
            }
            // FIXME: Animation doesn't work as intended because the cells move at the same time
            Rectangle()
                .frame(height: 1.2)
                .foregroundColor(isComplete ? .accentColor : .clear)
                .transition(.slide)
        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewBody(item: .constant(.mocked))
    }
    
    struct PreviewBody: View {
        @Binding var item: ListItem
        
        var body: some View {
            ListItemView(item: $item)
        }
    }
}
