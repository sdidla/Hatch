// swift-tools-version:6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import Foundation

let package = Package(
    name: "Hatch",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6),
        .macCatalyst(.v13),
    ],
    products: [
        .executable(name: "HatchExample", targets: ["HatchExample"]),
        .library(name: "Hatch", targets: ["Hatch"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", from: "600.0.0")
    ],
    targets: [
        .executableTarget(name: "HatchExample", dependencies: [.target(name: "Hatch")]),
        .target(
            name: "Hatch",
            dependencies: [
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftParser", package: "swift-syntax")
            ]
        ),
        .testTarget(name: "HatchTests", dependencies: ["Hatch"])
    ]
)
