import Foundation

// MARK: - Symbol Protocol

/// Represents a Swift type or symbol
public protocol Symbol {
    var children: [Symbol] { get }
}

/// Represent a Swift type that can inherit from or conform to other types
public protocol InheritingSymbol {
    var name: String { get }
    var inheritedTypes: [String] { get }
}

public extension Symbol {
    /// Returns an array containing the symbol and all its descendants
    func flattened() -> [Symbol] {
        [self] + children.flattened()
    }
}

public extension Array where Element == Symbol {
    /// Returns an array of symbols including descendants
    func flattened() -> [Symbol] {
        flatMap { [$0] + $0.children.flattened() }
    }
}

// MARK: - Concrete Symbols

/// A swift protocol
public typealias ProtocolType = Protocol

public struct Protocol: Symbol, InheritingSymbol  {
    public let name: String
    public let children: [Symbol]
    public let inheritedTypes: [String]
}

/// A swift class
public struct Class: Symbol, InheritingSymbol  {
    public let name: String
    public let children: [Symbol]
    public let inheritedTypes: [String]
}

/// A swift struct
public struct Struct: Symbol, InheritingSymbol  {
    public let name: String
    public let children: [Symbol]
    public let inheritedTypes: [String]
}

/// A swift enum
public struct Enum: Symbol, InheritingSymbol  {
    public let name: String
    public let children: [Symbol]
    public let inheritedTypes: [String]
}

/// A single case of a swift enum
public struct EnumCase: Symbol  {
    public let children: [Symbol]
}

/// A single element of a swift enum case
public struct EnumCaseElement: Symbol  {
    public let name: String
    public let children: [Symbol]
}

/// A swift typealias to an existing type
public struct Typealias: Symbol  {
    public let name: String
    public let existingType: String
    public let children: [Symbol] = []
}

/// A swift extension
public struct Extension: Symbol, InheritingSymbol  {
    public let name: String
    public let children: [Symbol]
    public let inheritedTypes: [String]
}
