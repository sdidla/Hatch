import SwiftSyntax
import SwiftSyntaxParser

/// A SyntaxVistor subclass that parses swift code into a hierarchical list of symbols
open class SymbolParser: SyntaxVisitor {

    // MARK: - Private

    private var scope: Scope = .root(symbols: [])

    // MARK: - Public

    /// Parses `source` and returns a hierarchical list of symbols from a string
    static public func parse(source: String) throws -> [Symbol] {
        let visitor = Self()
        try visitor.walk(SyntaxParser.parse(source: source))
        return visitor.scope.symbols
    }

    /// Designated initializer
    required public init() {
        super.init(viewMode: .sourceAccurate)
    }

    /// Starts a new scope which can contain zero or more nested symbols
    public func startScope() -> SyntaxVisitorContinueKind {
        scope.start()
        return .visitChildren
    }

    /// Ends the current scope and adds the symbol returned by the closure to the symbol tree
    /// - Parameter makeSymbolWithChildrenInScope: Closure that return a new ``Symbol``
    ///
    /// Call in `visitPost(_ node:)` methods
    public func endScopeAndAddSymbol(makeSymbolWithChildrenInScope: (_ children: [Symbol]) -> Symbol) {
        scope.end(makeSymbolWithChildrenInScope: makeSymbolWithChildrenInScope)
    }

    // MARK: - SwiftSyntax overridden methods

    open override func visit(_ node: ClassDeclSyntax) -> SyntaxVisitorContinueKind {
        startScope()
    }

    open override func visitPost(_ node: ClassDeclSyntax) {
        endScopeAndAddSymbol { children in
            Class(
                name: node.identifier.text,
                children: children,
                inheritedTypes: node.inheritanceClause?.types ?? []
            )
        }
    }

    open override func visit(_ node: ProtocolDeclSyntax) -> SyntaxVisitorContinueKind {
        startScope()
    }

    open override func visitPost(_ node: ProtocolDeclSyntax) {
        endScopeAndAddSymbol { children in
            Protocol(
                name: node.identifier.text,
                children: children,
                inheritedTypes: node.inheritanceClause?.types ?? []
            )
        }
    }

    open override func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
        startScope()
    }

    open override func visitPost(_ node: StructDeclSyntax) {
        endScopeAndAddSymbol { children in
            Struct(
                name: node.identifier.text,
                children: children,
                inheritedTypes: node.inheritanceClause?.types ?? []
            )
        }
    }

    open override func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
        startScope()
    }

    open override func visitPost(_ node: EnumDeclSyntax) {
        endScopeAndAddSymbol { children in
            Enum(
                name: node.identifier.text,
                children: children,
                inheritedTypes: node.inheritanceClause?.types ?? []
            )
        }
    }

    open override func visit(_ node: EnumCaseDeclSyntax) -> SyntaxVisitorContinueKind {
        startScope()
    }
    
    open override func visitPost(_ node: EnumCaseDeclSyntax) {
        endScopeAndAddSymbol { children in
            EnumCase(children: children)
        }
    }

    open override func visit(_ node: EnumCaseElementSyntax) -> SyntaxVisitorContinueKind {
        startScope()
    }
    
    open override func visitPost(_ node: EnumCaseElementSyntax) {
        endScopeAndAddSymbol { children in
            EnumCaseElement(
                name: node.identifier.text,
                children: children
            )
        }
    }

    open override func visit(_ node: TypealiasDeclSyntax) -> SyntaxVisitorContinueKind {
        startScope()
    }

    open override func visitPost(_ node: TypealiasDeclSyntax) {
        endScopeAndAddSymbol { children in
            Typealias(
                name: node.identifier.text,
                existingType: node.initializer.value.withoutTrivia().description
            )
        }
    }

    open override func visit(_ node: ExtensionDeclSyntax) -> SyntaxVisitorContinueKind {
        startScope()
    }

    open override func visitPost(_ node: ExtensionDeclSyntax) {
        endScopeAndAddSymbol { children in
            Extension(
                name: node.extendedType.withoutTrivia().description,
                children: children,
                inheritedTypes: node.inheritanceClause?.types ?? []
            )
        }
    }
}

public extension TypeInheritanceClauseSyntax {
    var types: [String] {
        inheritedTypeCollection.map {
            $0.typeName.withoutTrivia().description
        }
    }
}
