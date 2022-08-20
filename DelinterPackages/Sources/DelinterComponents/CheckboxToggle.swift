//
//  CheckboxToggle.swift
//  
//
//  Created by Rachel Schneebaum on 8/19/22.
//

import SwiftUI

public struct CheckboxToggle<Label: View>: View {
    @Binding var isOn: Bool
    let label: () -> Label
    
    public var body: some View {
        HStack(spacing: 0) {
            HStack {
                label()
                Spacer()
            }
            .contentShape(Rectangle())
            .simultaneousGesture(TapGesture().onEnded {
                isOn.toggle()
            })
            
            Button {
                isOn.toggle()
            } label: {
                Image(systemName: isOn ? "checkmark.square.fill" : "square")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(isOn ? .accentColor : .secondary)
            }
        }
    }
    
    /// - parameter isOn: binding indicating whether or not the checkbox is checked.
    /// - parameter label: any content associated with the checkbox (e.g., explainer text) that's:
    /// a) always tappable with the checkbox, and b) always positioned before (on the leading edge of) the checkbox
    ///
    /// - Note: If only a simple text label is needed, or no label at all, prefer the convenience initializers
    /// `init(isOn:)` or `init(isOn:label:font)`.
    public init(isOn: Binding<Bool>, @ViewBuilder label: @escaping () -> Label) {
        _isOn = isOn
        self.label = label
    }
}

// MARK: - Extensions

public extension CheckboxToggle where Label == EmptyView {
    /// Convenience initializer; prefer this initializer in cases where a lone, tappable checkbox (without any label, text, etc.) is needed.
    init(isOn: Binding<Bool>) {
        self.init(isOn: isOn) {
            EmptyView()
        }
    }
}

public extension CheckboxToggle where Label == Text {
    /// Convenience initializer for a checkbox a with text label on the leading side.
    /// Pass in a custom font if desired; otherwise uses system default
    init(isOn: Binding<Bool>, label: String, font: Font? = nil) {
        self.init(isOn: isOn) {
            Text(label)
                .font(font)
        }
    }
}

struct CheckboxToggle_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    struct Preview: View {
        @State private var isOn = false
        
        var body: some View {
            List {
                CheckboxToggle(isOn: $isOn)
                
                CheckboxToggle(isOn: $isOn, label: "Test Checkbox Label")
                
                CheckboxToggle(
                    isOn: $isOn,
                    label: "Test Checkbox Label",
                    font: .system(size: 20, weight: .ultraLight, design: .rounded)
                )
                
                CheckboxToggle(isOn: $isOn) {
                    VStack {
                        Text("Custom label")
                        Text("🧼 🧠")
                        Image(systemName: "bicycle")
                    }
                }
            }
        }
    }
}
