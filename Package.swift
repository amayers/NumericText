// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NumericText",
    platforms: [.iOS(.v13), .macOS(.v10_15), .watchOS(.v6), .tvOS(.v13)],
    products: [
        .library(
            name: "NumericText",
            targets: ["NumericText"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "NumericText",
            dependencies: []),
        .testTarget(
            name: "NumericTextTests",
            dependencies: ["NumericText"]),
    ]
)
