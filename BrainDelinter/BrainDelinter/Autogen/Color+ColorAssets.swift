// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import SwiftUI

public extension Color {
  static let accentColorOpaque = Color("AccentColorOpaque", bundle: BundleToken.bundle)
  static let secondaryColor = Color("SecondaryColor", bundle: BundleToken.bundle)
}


// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}

// swiftlint:enable convenience_type
