[![GitHub license](https://img.shields.io/github/license/sdidla/Hatch)](https://github.com/sdidla/Hatch/blob/main/LICENSE)
![CircleCI](https://img.shields.io/circleci/build/github/sdidla/Hatch?label=build%2C%20test%20and%20document)

# Hatch

Generate Swift using Swift.

This package contains two modules:
- `HatchParser` Provides a simple, extensible parser to to get a hierarchical list of symbols from swift code using [SwiftSyntax](https://github.com/apple/swift-syntax)
- `HatchBuilder` Provides a string concatenating `resultBuidler` so expressions can be interspersed with strings 

## Documentation

- [`HatchParser`](https://sdidla.github.io/Hatch/docs/HatchParser/documentation/hatchparser/)
   
## Releases

Hatch [releases](https://github.com/sdidla/Hatch/releases/) correspond to releases of [SwiftSyntax](https://github.com/apple/swift-syntax)

## Example

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
