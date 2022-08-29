// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Localized {
  internal enum Alarm {
    internal enum End {
      /// finish up whatever you're going and give yourself a pat on the back because you did it!
      internal static let body = Localized.tr("Localizable", "Alarm.End.body", fallback: "finish up whatever you're going and give yourself a pat on the back because you did it!")
      /// it's over!
      internal static let title = Localized.tr("Localizable", "Alarm.End.title", fallback: "it's over!")
    }
    internal enum Start {
      /// ready to get things done?? you got this!
      internal static let body = Localized.tr("Localizable", "Alarm.Start.body", fallback: "ready to get things done?? you got this!")
      /// it's go time
      internal static let title = Localized.tr("Localizable", "Alarm.Start.title", fallback: "it's go time")
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
