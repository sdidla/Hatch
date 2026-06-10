import Foundation
import Hatch

public let projectURL = URL(filePath: #filePath)
    .deletingLastPathComponent()
    .deletingLastPathComponent()
    .appendingPathComponent("NotificationCenter")

public func projectSymbols() -> [Symbol] {
    let symbols = try? FileManager.default
            .enumerator(at: projectURL, includingPropertiesForKeys: nil)?
            .compactMap { $0 as? URL }
            .filter { $0.hasDirectoryPath == false }
            .filter { $0.pathExtension == "swift" }
            .map { try String(contentsOf: $0, encoding: .utf8) }
            .flatMap { SymbolParser.parse(source: $0) }

    return symbols ?? []
}
