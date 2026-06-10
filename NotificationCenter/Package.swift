// swift-tools-version: 6.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NotificationCenter",
    platforms: [.iOS(.v18), .macOS(.v15)],
    products: [
        .library(name: "NotificationCenter", targets: ["NotificationCenter"]),
    ],
    targets: [
        .target(
            name: "NotificationCenter",
            swiftSettings: [
                .enableUpcomingFeature("ApproachableConcurrency"),
            ],
        ),
    ],
    swiftLanguageModes: [.v6]
)
