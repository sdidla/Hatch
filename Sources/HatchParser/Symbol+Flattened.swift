import Foundation

public extension Symbol {
    /// Returns an array containing the symbol and all its descendants
    func flattened() -> [Symbol] {
        [self] + children.flattened()
    }
}

public extension Collection where Element == Symbol {
    /// Returns an array of symbols including descendants
    func flattened() -> [Symbol] {
        flatMap { [$0] + $0.children.flattened() }
    }
}
