// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum TL {
  /// Plural format key: "%#@VARIABLE@"
  public static func stringKey(_ p1: Int) -> String {
    return TL.tr("Localizable", "StringKey", p1, fallback: "Plural format key: \"%#@VARIABLE@\"")
  }
  /// Localizable.strings
  ///   TOOTutils
  /// 
  ///   Created by thor on 17/3/24.
  public static let tootStr1 = TL.tr("Localizable", "TOOT_str1", fallback: "TOOT string 1 for english language....")
  /// TOOT string 22222 for english language....
  public static let tootStr2 = TL.tr("Localizable", "TOOT_str2", fallback: "TOOT string 22222 for english language....")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension TL {
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
