import SwiftUI

public extension View {
    func disabledAppearance(_ disabled: Bool) -> some View {
        modifier(DisabledStateModifier(disabled: disabled))
    }
}

struct DisabledStateModifier: ViewModifier {
    var disabled: Bool
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(disabled ? .lightGray : nil)
            .disabled(disabled)
    }
}
