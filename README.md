[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsdidla%2FHatch%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/sdidla/Hatch)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsdidla%2FHatch%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/sdidla/Hatch)
[![GitHub license](https://img.shields.io/github/license/sdidla/Hatch)](https://github.com/sdidla/Hatch/blob/main/LICENSE)
[![Tests](https://github.com/sdidla/Hatch/actions/workflows/unit-tests.yml/badge.svg)](https://github.com/sdidla/Hatch/actions/workflows/unit-tests.yml)

# Hatch

A simple, extensible parser to to get a hierarchical list of symbols from swift code using [SwiftSyntax](https://github.com/apple/swift-syntax)

## Documentation

- [Hatch Documentation](https://swiftpackageindex.com/sdidla/Hatch/main/documentation/hatch)

## Usage

When using Swift Package Manager, add the following to your package dependencies in the `Package.swift` file:

```swift
  .package(url: "https://github.com/sdidla/Hatch.git", from: "<#latest swift-syntax tag#>")
```

## Releases

Hatch [releases](https://github.com/sdidla/Hatch/releases/) correspond to releases of [SwiftSyntax](https://github.com/apple/swift-syntax)

## Example

```swift
import Hatch

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
  ▿ Hatch.Struct
    - name: "A1"
    ▿ children: 3 elements
      ▿ Hatch.Struct
        - name: "BC"
        ▿ children: 3 elements
          ▿ Hatch.Struct
            - name: "C1"
            - children: 0 elements
            - inheritedTypes: 0 elements
          ▿ Hatch.Struct
            - name: "C2"
            - children: 0 elements
            - inheritedTypes: 0 elements
          ▿ Hatch.Struct
            - name: "C3"
            - children: 0 elements
            - inheritedTypes: 0 elements
        - inheritedTypes: 0 elements
      ▿ Hatch.Struct
        - name: "BD"
        ▿ children: 2 elements
          ▿ Hatch.Struct
            - name: "D1"
            - children: 0 elements
            - inheritedTypes: 0 elements
          ▿ Hatch.Struct
            - name: "D2"
            - children: 0 elements
            - inheritedTypes: 0 elements
        - inheritedTypes: 0 elements
      ▿ Hatch.Struct
        - name: "BX"
        - children: 0 elements
        - inheritedTypes: 0 elements
    - inheritedTypes: 0 elements
  ▿ Hatch.Struct
    - name: "A2"
    - children: 0 elements
    - inheritedTypes: 0 elements
  ▿ Hatch.Enum
    - name: "MyEnum"
    - children: 0 elements
    - inheritedTypes: 0 elements
```
