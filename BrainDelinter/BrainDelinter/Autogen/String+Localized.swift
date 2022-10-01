// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Localized {
  internal enum List {
    /// 🧹 write down any task taking up space in your head... then ignore it!
    internal static let description = Localized.tr("Localizable", "List.description", fallback: "🧹 write down any task taking up space in your head... then ignore it!")
    /// add some lint
    internal static let textFieldLabel = Localized.tr("Localizable", "List.textFieldLabel", fallback: "add some lint")
    /// lint list 🧺
    internal static let title = Localized.tr("Localizable", "List.title", fallback: "lint list 🧺")
  }
  internal enum Settings {
    /// settings ⚙️
    internal static let title = Localized.tr("Localizable", "Settings.title", fallback: "settings ⚙️")
    internal enum Alarm {
      /// pick a time to start Getting Things Done!
      internal static let description = Localized.tr("Localizable", "Settings.Alarm.description", fallback: "pick a time to start Getting Things Done!")
      /// alarm settings
      internal static let sectionHeader = Localized.tr("Localizable", "Settings.Alarm.sectionHeader", fallback: "alarm settings")
      /// daily alarm
      internal static let title = Localized.tr("Localizable", "Settings.Alarm.title", fallback: "daily alarm")
    }
    internal enum ClearAll {
      /// careful, this can't be undone! 😬
      internal static let body = Localized.tr("Localizable", "Settings.ClearAll.body", fallback: "careful, this can't be undone! 😬")
      /// clear all list items
      internal static let title = Localized.tr("Localizable", "Settings.ClearAll.title", fallback: "clear all list items")
    }
    internal enum Duration {
      /// 20 minutes is the recommended duration: short enough to feel doable, long enough to accomplish something(s)!
      internal static let description = Localized.tr("Localizable", "Settings.Duration.description", fallback: "20 minutes is the recommended duration: short enough to feel doable, long enough to accomplish something(s)!")
      /// productivity duration
      internal static let title = Localized.tr("Localizable", "Settings.Duration.title", fallback: "productivity duration")
    }
    internal enum List {
      /// list settings
      internal static let sectionHeader = Localized.tr("Localizable", "Settings.List.sectionHeader", fallback: "list settings")
    }
    internal enum ShowComplete {
      /// display the day's completed items in your lint list
      internal static let body = Localized.tr("Localizable", "Settings.ShowComplete.body", fallback: "display the day's completed items in your lint list")
      /// show completed items
      internal static let title = Localized.tr("Localizable", "Settings.ShowComplete.title", fallback: "show completed items")
    }
    internal enum Snooze {
      /// if checked, we'll notify you again in 5 minutes
      internal static let description = Localized.tr("Localizable", "Settings.Snooze.description", fallback: "if checked, we'll notify you again in 5 minutes")
      /// allow snooze?
      internal static let title = Localized.tr("Localizable", "Settings.Snooze.title", fallback: "allow snooze?")
    }
  }
  internal enum Stats {
    /// stats 📈
    internal static let title = Localized.tr("Localizable", "Stats.title", fallback: "stats 📈")
    /// track your progress over time!
    internal static let wipExplainerBody = Localized.tr("Localizable", "Stats.wipExplainerBody", fallback: "track your progress over time!")
    /// coming soon...
    internal static let wipExplainerHeader = Localized.tr("Localizable", "Stats.wipExplainerHeader", fallback: "coming soon...")
  }
  internal enum Tab {
    /// list
    internal static let list = Localized.tr("Localizable", "Tab.list", fallback: "list")
    /// settings
    internal static let settings = Localized.tr("Localizable", "Tab.settings", fallback: "settings")
    /// stats
    internal static let stats = Localized.tr("Localizable", "Tab.stats", fallback: "stats")
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
