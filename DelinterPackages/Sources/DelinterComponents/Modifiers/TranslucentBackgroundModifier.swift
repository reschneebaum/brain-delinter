import SwiftUI

public extension View {
    func backgroundColorOnWhite(_ color: Color) -> some View {
        modifier(TranslucentBackgroundModifier(backgroundColor: color))
    }
}

struct TranslucentBackgroundModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    var backgroundColor: Color
    
    func body(content: Content) -> some View {
        content.background(
            Group {
                switch colorScheme {
                case .light:
                    ZStack {
                        Color.white
                        backgroundColor
                    }
                case .dark:
                    backgroundColor
                @unknown default:
                    backgroundColor
                }
            }
        )
    }
}
