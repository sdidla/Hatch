// swift-tools-version: 6.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NotificationCenter",
    platforms: [.iOS(.v18), .macOS(.v15)],
    products: [
        .library(name: "NotificationCenter", targets: ["NotificationCenter"]),
        .library(name: "NotificationCodeGen", targets: ["NotificationCodeGen"])
    ],
    dependencies: [
        .package(url: "https://github.com/JohnSundell/Splash", from: "0.16.0"),
        .package(path: "..") // Hatch
            
    ],
    targets: [
        .target(name: "NotificationCenter"),
        
        .executableTarget(
            name: "NotificationCodeGenCLI",
            dependencies: ["NotificationCodeGen"]
        ),
        .target(
            name: "NotificationCodeGen",
            dependencies: [
                .product(name: "Splash", package: "Splash"),
                .product(name: "Hatch", package: "Hatch")
            ],
        ),
    ],
    swiftLanguageModes: [.v6]
)
