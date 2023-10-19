import Foundation

/// Provides string concatenation support to make it easier to generate swift code
///
/// Example:
/// ```swift
/// @StringBuilder var myFile: String {
///     """
///     switch symbol {
///     """
///
///     for symbol in symbolNames {
///     """
///         case \(symbol)
///     """
///     }
///
///     """
///     }
///     """
/// }
///
/// try myFile.write(toFile: "myFile.swift", atomically: true, encoding: .utf8)
/// ```
@resultBuilder public struct StringBuilder {
    static public func buildBlock(_ components: String?...) -> String? {
        return components.compactMap { $0 }.joined(separator: "\n")
    }

    static public func buildArray(_ components: [String?]) -> String? {
        return components.compactMap { $0 }.joined(separator: "\n")
    }

    static public func buildEither(first component: String?) -> String? {
        component
    }

    static public func buildEither(second component: String?) -> String? {
        component
    }

    static public func buildOptional(_ component: String?) -> String? {
        component
    }

    static public func buildLimitedAvailability(_ component: String) -> String? {
        component
    }

    public static func buildFinalResult(_ component: String?) -> String {
        component ?? ""
    }
}
