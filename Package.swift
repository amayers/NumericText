// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NumericText",
    platforms: [.iOS(.v14), .macOS(.v10_16), .watchOS(.v7), .tvOS(.v14)],
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
