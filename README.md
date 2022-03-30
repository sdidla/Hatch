![Tests](https://github.com/sdidla/Hatch/actions/workflows/swift.yml/badge.svg)

# Hatch

Generate Swift using Swift.

This package contains two libraries
- `HatchParser`: Parses swift code into a symbol tree using [SwiftSyntax 0.50600.1](https://github.com/apple/swift-syntax)
- `HatchBuilder`: Provides a tiny `resultBuidler` based API to generate `.swift` files

### HatchParser

#### Simple Usage

```swift
import HatchParser

let source: String = <some swift code>
let symbols = SymbolParser.parse(source: source)

dump(symbols)
```

Input:
    
```swift
struct A1 {

    struct BC {
        struct C1 {}
        struct C2 {}
        struct C3 {}
    }

    struct BD {
        struct D1 {}
        struct D2 {}
    }

    struct BX {}
}

struct A2 {}

enum MyEnum {}
```

Output:

```
▿ 3 elements
  ▿ HatchParser.Struct
    - name: "A1"
    ▿ children: 3 elements
      ▿ HatchParser.Struct
        - name: "BC"
        ▿ children: 3 elements
          ▿ HatchParser.Struct
            - name: "C1"
            - children: 0 elements
            - inheritedTypes: 0 elements
          ▿ HatchParser.Struct
            - name: "C2"
            - children: 0 elements
            - inheritedTypes: 0 elements
          ▿ HatchParser.Struct
            - name: "C3"
            - children: 0 elements
            - inheritedTypes: 0 elements
        - inheritedTypes: 0 elements
      ▿ HatchParser.Struct
        - name: "BD"
        ▿ children: 2 elements
          ▿ HatchParser.Struct
            - name: "D1"
            - children: 0 elements
            - inheritedTypes: 0 elements
          ▿ HatchParser.Struct
            - name: "D2"
            - children: 0 elements
            - inheritedTypes: 0 elements
        - inheritedTypes: 0 elements
      ▿ HatchParser.Struct
        - name: "BX"
        - children: 0 elements
        - inheritedTypes: 0 elements
    - inheritedTypes: 0 elements
  ▿ HatchParser.Struct
    - name: "A2"
    - children: 0 elements
    - inheritedTypes: 0 elements
  ▿ HatchParser.Enum
    - name: "MyEnum"
    - children: 0 elements
    - inheritedTypes: 0 elements

```

#### Advanced Usage

By subclassing `SymbolParser`, and overriding `SyntaxVisitor` methods, you can get more information into your symbol tree

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

### HatchBuilder
```swift
import HatchBuilder

@CodeBuilder var myFile: String {
    """
    switch signal {
    """

    for signalName in signalNames {
    """
        case \(signalName)
    """
    }

    """
    }
    """
}

try myFile.write(toFile: "myFile.swift", atomically: true, encoding: .utf8)
```
