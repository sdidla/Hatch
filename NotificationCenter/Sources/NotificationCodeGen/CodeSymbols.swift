import Hatch
import Foundation

let projectURL = URL(filePath: #filePath)
    .deletingLastPathComponent()
    .deletingLastPathComponent()
    .appendingPathComponent("NotificationCenter")

let projectSymbols = try? FileManager.default
        .enumerator(at: projectURL, includingPropertiesForKeys: nil)?
        .compactMap { $0 as? URL }
        .filter { $0.hasDirectoryPath == false }
        .filter { $0.pathExtension == "swift" }
        .flatMap { try SymbolParser.parse(source: String(contentsOf: $0, encoding: .utf8)) }
