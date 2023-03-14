# ``HatchBuilder``

HatchBuilder provides an extremely simple string concatenating `resultBuilder` called ``StringBuilder``

## Usage

```swift
import HatchBuilder

@StringBuilder var myFile: String {
    """
    switch symbol {
    """

    for symbol in symbolNames {
    """
        case \(symbol)
    """
    }

    """
    }
    """
}

try myFile.write(toFile: "myFile.swift", atomically: true, encoding: .utf8)
```
