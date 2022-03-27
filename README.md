# Hatch

Generate Swift using Swift.

This package contains two libraries
- `HatchExtractor`: Parses swift code into a symbol tree using [SwiftSyntax 0.50600.1](https://github.com/apple/swift-syntax)
- `HatchBuilder`: Provides a tiny `resultBuidler` based API to generate `.swift` files

## Usage

1. Hatch is a library designed to be imported into your project using Swift Package Manager. Add this to your dependencies in `Package.swift`.

```swift
.package(name: "Hatch", url: "https://source.xing.com/shammi-didla/Hatch", branch: "main")
```

2. Use `extract(from:visitor:)` to read symbols from contents of a file or a string

3. Use ``@CodeBuilder`` as a poor man's templating solution.

## Example

### HatchExtractor

#### Simple Usage

```swift
import HatchExtractor

let path = "~/Repositories/monorepi/libraries/SUPI/SUPI/Classes/NetworkUpdates" as NSString
let directoryURL = URL(fileURLWithPath: path.expandingTildeInPath)
let fileURLs = FileManager.default.filesInDirectory(directoryURL)
let symbols = try fileURLs.flatMap { try extract(from: String(contentsOf: $0)) }

dump(symbols)
```

<details>
    <summary>Sample</summary>

Input:
    
```swift
// start scope
struct A1 {

    // start scope
    struct BC {

        // start scope
        struct C1 {
        }
        // end scope. retrieve previousscope. create node. add as child

        // start scope
        struct C2 {
        }
        // end scope. retrieve previousscope. create node. add as child

        struct C3 {
        }
        // end scope. retrieve previousscope. create node. add as child

    }
    // end scope. retrieve previousscope. create node. add as child


    struct BD {
        struct D1 {}
        struct D2 {}
    }

    struct BX {
    }

}

struct A2 {
}

enum MyEnum {
}
```

Output:
```
▿ 3 elements
  ▿ HatchExtractor.Struct
    - name: "A1"
    ▿ children: 3 elements
      ▿ HatchExtractor.Struct
        - name: "BC"
        ▿ children: 3 elements
          ▿ HatchExtractor.Struct
            - name: "C1"
            - children: 0 elements
            - inheritedTypes: 0 elements
          ▿ HatchExtractor.Struct
            - name: "C2"
            - children: 0 elements
            - inheritedTypes: 0 elements
          ▿ HatchExtractor.Struct
            - name: "C3"
            - children: 0 elements
            - inheritedTypes: 0 elements
        - inheritedTypes: 0 elements
      ▿ HatchExtractor.Struct
        - name: "BD"
        ▿ children: 2 elements
          ▿ HatchExtractor.Struct
            - name: "D1"
            - children: 0 elements
            - inheritedTypes: 0 elements
          ▿ HatchExtractor.Struct
            - name: "D2"
            - children: 0 elements
            - inheritedTypes: 0 elements
        - inheritedTypes: 0 elements
      ▿ HatchExtractor.Struct
        - name: "BX"
        - children: 0 elements
        - inheritedTypes: 0 elements
    - inheritedTypes: 0 elements
  ▿ HatchExtractor.Struct
    - name: "A2"
    - children: 0 elements
    - inheritedTypes: 0 elements
  ▿ HatchExtractor.Enum
    - name: "MyEnum"
    - children: 0 elements
    - inheritedTypes: 0 elements

```
</details>

#### Advanced Usage

By subclassing ``SymbolVisitor``, and extracting specific information, you can get more information into your symbol tree

1. Sublass ``SymbolVisitor``
2. Override the `visitPost(_ node:)` methods to to create your own symbol type.
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
