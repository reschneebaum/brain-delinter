import SwiftUI

public extension Color {
    /// Use this color instead of the system `.black` when some element should be black in both light and dark mode
    /// (e.g., text in a text field with a light background).
    static let alwaysBlack: Color = .init(red: 0, green: 0, blue: 0)
    
    static let lightGray: Color = .init(uiColor: .lightGray)
    static let darkGray: Color = .init(uiColor: .darkGray)
}
