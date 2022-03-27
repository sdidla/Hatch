# ``HatchExtractor``

HatchExtractor is an simple, extensible symbol parser based on `SwiftSyntax`

## Simple Usage

Extracting symbols from a string or contents of a file using ``extract(from:visitor:)``

```swift
import HatchExtractor

let path = "~/Repositories/monorepi/libraries/SUPI/SUPI/Classes/NetworkUpdates" as NSString
let directoryURL = URL(fileURLWithPath: path.expandingTildeInPath)
let fileURLs = FileManager.default.filesInDirectory(directoryURL)
let symbols = try fileURLs.flatMap { try extract(from: String(contentsOf: $0)) }

dump(symbols)
```

You can use swift standard library methods to `filter`, `map`, `compactMap` etc. `HatchExtractor` provides an additional method on a collection of symbols or a ``Symbol`` called ``Symbol/flattened()`` that returns a flat array of symbols derived from the symbol tree while preserving the subtree

For example, to extract all the enum case elements from a specific enum, you can do:

```swift
symbols
    .filter { $0.name == "ContentType" }
    .first?
    .flattened()
    .compactMap { $0 as? EnumCaseElement }
    .map(\.name)
```

## Advanced Usage

Extending `HatchExtractor`

1. Sublass ``SymbolVisitor``
2. Override the `visitPost(_ node:)` methods to create your own symbol.
3. Pass in your custom visitor to ``extract(from:visitor:)``

The following listing shows an example of adding generic where clause support:

```swift
class MySpecialVisitor: SymbolVisitor {
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

