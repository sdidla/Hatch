import Foundation

@resultBuilder public struct StringBuilder {
    static public func buildBlock(_ components: String...) -> String {
        return components.joined(separator: "\n")
    }

    static public func buildArray(_ components: [String]) -> String {
        return components.joined(separator: "\n")
    }

    static public func buildEither(first component: String) -> String {
        component
    }

    static public func buildEither(second component: String) -> String {
        component
    }

    static public func buildOptional(_ component: String?) -> String {
        component ?? ""
    }

    static public func buildLimitedAvailability(_ component: String) -> String {
        component
    }
}
