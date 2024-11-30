import Foundation

// MARK: - Symbol Protocol

/// Represents a Swift type or symbol
public protocol Symbol: Sendable {
    var children: [Symbol] { get }
}

/// Represent a Swift type that can inherit from or conform to other types
public protocol InheritingSymbol: Sendable {
    var name: String { get }
    var inheritedTypes: [String] { get }
}

// MARK: - Concrete Symbols

/// A swift protocol
public typealias ProtocolType = Protocol

public struct Protocol: Symbol, InheritingSymbol, Sendable  {
    public let name: String
    public let children: [Symbol]
    public let inheritedTypes: [String]
}

/// A swift class
public struct Class: Symbol, InheritingSymbol, Sendable  {
    public let name: String
    public let children: [Symbol]
    public let inheritedTypes: [String]
}

/// A swift actor
public struct Actor: Symbol, InheritingSymbol, Sendable  {
    public let name: String
    public let children: [Symbol]
    public let inheritedTypes: [String]
}

/// A swift struct
public struct Struct: Symbol, InheritingSymbol, Sendable  {
    public let name: String
    public let children: [Symbol]
    public let inheritedTypes: [String]
}

/// A swift enum
public struct Enum: Symbol, InheritingSymbol, Sendable  {
    public let name: String
    public let children: [Symbol]
    public let inheritedTypes: [String]
}

/// A single case of a swift enum
public struct EnumCase: Symbol, Sendable  {
    public let children: [Symbol]
}

/// A single element of a swift enum case
public struct EnumCaseElement: Symbol, Sendable  {
    public let name: String
    public let children: [Symbol]
}

/// A swift typealias to an existing type
public struct Typealias: Symbol, Sendable  {
    public let name: String
    public let existingType: String
    public let children: [Symbol] = []
}

/// A swift extension
public struct Extension: Symbol, InheritingSymbol, Sendable  {
    public let name: String
    public let children: [Symbol]
    public let inheritedTypes: [String]
}
