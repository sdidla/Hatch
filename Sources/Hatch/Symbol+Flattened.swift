import Foundation

public extension Collection where Element == Symbol {
    /// Returns an array of symbols including descendants
    func flattened() -> [Symbol] {
        flatMap { [$0] + $0.children.flattened() }
    }
}
