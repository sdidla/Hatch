// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import Foundation

let package = Package(
    name: "Hatch",
    platforms: [.iOS(.v13), .macOS(.v10_15)],
    products: [
        .executable(name: "HatchExample", targets: ["HatchExample"]),
        .library(name: "HatchParser", targets: ["HatchParser"]),
        .library(name: "HatchBuilder", targets: ["HatchBuilder"]),
    ],
    dependencies: [
        .package(name: "swift-syntax", url: "https://github.com/apple/swift-syntax.git", from: "509.0.0")
    ],
    targets: [
        .executableTarget(
            name: "HatchExample",
            dependencies: [
                .target(name: "HatchParser"),
                .target(name: "HatchBuilder")
            ]
        ),
        .target(
            name: "HatchParser",
            dependencies: [
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftParser", package: "swift-syntax")
            ]
        ),
        .target(
            name: "HatchBuilder"
        ),

        .testTarget(
            name: "HatchParserTests",
            dependencies: ["HatchParser"]
        )
    ]
)

if ProcessInfo.processInfo.environment["CI"] == "true" {
    package.dependencies += [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
    ]
}

