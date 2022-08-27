// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Localized {

  internal enum List {
    /// add it to the list so you don't have to think about it anymore
    internal static let description = Localized.tr("Localizable", "List.description")
    /// 🧠 get the lint out! 🧼
    internal static let subheader = Localized.tr("Localizable", "List.subheader")
    /// add some lint
    internal static let textFieldLabel = Localized.tr("Localizable", "List.textFieldLabel")
    /// lint list
    internal static let title = Localized.tr("Localizable", "List.title")
  }

  internal enum Settings {
    /// Settings
    internal static let title = Localized.tr("Localizable", "Settings.title")
    internal enum Alarm {
      /// pick a time to start Getting Things Done!
      internal static let description = Localized.tr("Localizable", "Settings.Alarm.description")
      /// alarm settings
      internal static let sectionHeader = Localized.tr("Localizable", "Settings.Alarm.sectionHeader")
      /// daily alarm
      internal static let title = Localized.tr("Localizable", "Settings.Alarm.title")
    }
    internal enum Duration {
      /// we strongly recommend a 'do things' time of 20 minutes; much longer (or shorter) won't have the desired effect.
      internal static let description = Localized.tr("Localizable", "Settings.Duration.description")
      /// how long?
      internal static let title = Localized.tr("Localizable", "Settings.Duration.title")
    }
    internal enum Snooze {
      /// if checked, we'll notify you again in 5 minutes
      internal static let description = Localized.tr("Localizable", "Settings.Snooze.description")
      /// allow snooze?
      internal static let title = Localized.tr("Localizable", "Settings.Snooze.title")
    }
  }

  internal enum Stats {
    /// Stats
    internal static let title = Localized.tr("Localizable", "Stats.title")
    /// track your progress over time!
    internal static let wipExplainerBody = Localized.tr("Localizable", "Stats.wipExplainerBody")
    /// coming soon...
    internal static let wipExplainerHeader = Localized.tr("Localizable", "Stats.wipExplainerHeader")
  }

  internal enum Tab {
    /// list
    internal static let list = Localized.tr("Localizable", "Tab.list")
    /// settings
    internal static let settings = Localized.tr("Localizable", "Tab.settings")
    /// stats
    internal static let stats = Localized.tr("Localizable", "Tab.stats")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Localized {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
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
