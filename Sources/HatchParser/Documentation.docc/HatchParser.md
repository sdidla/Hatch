# ``HatchParser``

HatchParser is a simple, extensible symbol parser based on `SwiftSyntax`

## Usage

Extracting symbols from a string or contents of a file using ``SymbolParser/parse(source:)``

```swift
import HatchParser

let path = "~/Repositories/myProject"
let directoryURL = URL(fileURLWithPath: path)

let allSymbols = try FileManager.default
    .enumerator(at: directoryURL, includingPropertiesForKeys: nil)?
    .compactMap { $0 as? URL }
    .filter { $0.hasDirectoryPath == false }
    .filter { $0.pathExtension == "swift" }
    .flatMap { SymbolParser.parse(source: String(contentsOf: $0)) }

dump(allSymbols)
```

You can use swift standard library methods to `filter`, `map`, `compactMap` etc. `HatchParser` provides an additional method on a collection of symbols called ``Symbol/flattened()`` that returns a flat array of symbols derived from the symbol tree while preserving the subtree

For example, to extract all the enum case elements from a specific enum, you can do:

```swift
symbols
    .filter { $0.name == "ContentType" }
    .first?
    .flattened()
    .compactMap { $0 as? EnumCaseElement }
    .map(\.name)
```

## Subclassing SymbolParser

1. Sublass ``SymbolParser``
2. Override the relevant `visit(_ node:)` method of `SyntaxVisitor` and call ``SymbolParser/startScope()`` 
3. Override the corresponding `visitPost(_ node:)` method of `SyntaxVisitor` to create your own symbol using ``SymbolParser/endScopeAndAddSymbol(makeSymbolWithChildrenInScope:)`` and return a type that comforms to ``Symbol``

The following listing shows an example of adding generic where clause support:

```swift
class MySpecialVisitor: SymbolParser {
    override func visitPost(_ node: StructDeclSyntax) {
        if let genericWhereClause = node.genericWhereClause {
            endScopeAndAddSymbol { children in
                MySpecialStruct(
                    name: node.identifier.text,
                    children: children,
                    genericWhereClause: genericWhereClause.description
                )
            }
        } else {
            super.visitPost(node)
        }
    }
}

struct MySpecialStruct: Symbol {
    let name: String
    let children: [Symbol]
    let genericWhereClause: String
}
```

