//
//  TimePicker.swift
//  
//
//  Created by Rachel Schneebaum on 8/19/22.
//

import SwiftUI

public struct TimePicker<Label: View>: View {
    @Binding var selectedTime: Date
    let label: () -> Label
    @State private var accessibilityLabel = "Time picker"
    
    public var body: some View {
        DatePicker(selection: $selectedTime, displayedComponents: .hourAndMinute) {
                label().contentShape(Rectangle())
        }
        .datePickerStyle(.graphical)
        .accessibilityLabel(accessibilityLabel)
    }
    
    /// - parameter selectedTime: binding indicating the picker's currently selected/displayed date.
    /// - parameter label: any content associated with the picker (e.g., explainer text/label) that's:
    /// a) always tappable with the picker, and b) always positioned before (on the leading edge of) the picker
    ///
    /// - Note: If only a simple text label is needed, or no label at all, prefer the convenience initializers
    /// `init(selectedTime:)` or `init(selectedTime:label:font)`.
    public init(selectedTime: Binding<Date>, @ViewBuilder label: @escaping () -> Label) {
        _selectedTime = selectedTime
        self.label = label
    }
}

// MARK: - Extensions

public extension TimePicker where Label == EmptyView {
    /// Convenience initializer for cases where a picker with no label is desired.
    init(selectedTime: Binding<Date>) {
        self.init(selectedTime: selectedTime) {
            EmptyView()
        }
    }
}

public extension TimePicker where Label == Text {
    /// Convenience initializer for cases where the picker `label` is a single `Text`.
    init(selectedTime: Binding<Date>, label: String, font: Font? = nil) {
        self.init(selectedTime: selectedTime) {
            Text(label)
                .font(font)
        }
        accessibilityLabel = label
    }
}

struct TimePicker_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    struct Preview: View {
        @State private var selected: Date = .now
        
        var body: some View {
            List {
                TimePicker(selectedTime: $selected)
                
                TimePicker(selectedTime: $selected, label: "Test picker label")
                
                TimePicker(
                    selectedTime: $selected,
                    label: "Test picker label",
                    font: .system(size: 20, weight: .ultraLight, design: .rounded)
                )
                
                TimePicker(selectedTime: $selected) {
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
