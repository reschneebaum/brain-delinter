// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Localized {
  /// cancel
  internal static let cancel = Localized.tr("Localizable", "cancel", fallback: "cancel")
  /// error
  internal static let error = Localized.tr("Localizable", "error", fallback: "error")
  /// ok
  internal static let ok = Localized.tr("Localizable", "ok", fallback: "ok")
  internal enum Alert {
    internal enum ClearList {
      /// I'm sure
      internal static let actionTitle = Localized.tr("Localizable", "Alert.ClearList.actionTitle", fallback: "I'm sure")
      /// (this will delete *all* list items, complete and incomplete)
      internal static let message = Localized.tr("Localizable", "Alert.ClearList.message", fallback: "(this will delete *all* list items, complete and incomplete)")
      /// you sure?
      internal static let title = Localized.tr("Localizable", "Alert.ClearList.title", fallback: "you sure?")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Localized {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
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
