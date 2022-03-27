// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import Foundation

let package = Package(
    name: "Hatch",
    platforms: [.iOS(.v13), .macOS(.v10_15)],
    products: [
        .executable(name: "HatchExample", targets: ["HatchExample"]),
        .library(name: "HatchExtractor", targets: ["HatchExtractor"]),
        .library(name: "HatchBuilder", targets: ["HatchBuilder"]),
    ],
    dependencies: [
        .package(name: "SwiftSyntax", url: "https://github.com/apple/swift-syntax.git", .exact("0.50600.1"))
    ],
    targets: [
        .executableTarget(
            name: "HatchExample",
            dependencies: [
                .target(name: "HatchExtractor"),
                .target(name: "HatchBuilder")
            ]
        ),

        .target(
            name: "HatchExtractor",
            dependencies: [
                .product(name: "SwiftSyntax", package: "SwiftSyntax"),
                .product(name: "SwiftSyntaxParser", package: "SwiftSyntax")
            ]
        ),
        
        .target(
            name: "HatchBuilder"
        ),

        .testTarget(
            name: "HatchExtractorTests",
            dependencies: [
                "HatchExtractor"
            ],
            resources: [
                .copy("RootDirectoryMock")
            ]
        )
    ]
)
