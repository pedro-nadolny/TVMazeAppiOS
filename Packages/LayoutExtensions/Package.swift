// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "LayoutExtensions",
    products: [
        .library(
            name: "LayoutExtensions",
            targets: ["LayoutExtensions"]),
    ],
    dependencies: [],
    targets: [

        .target(
            name: "LayoutExtensions",
            dependencies: []),
        .testTarget(
            name: "LayoutExtensionsTests",
            dependencies: ["LayoutExtensions"]),
    ]
)
