// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Core",
    products: [
        .library(
            name: "Core",
            targets: ["Core"]),
        .library(
            name: "CoreInterface",
            targets: ["CoreInterface"]),
    ],
    dependencies: [
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "Core",
            dependencies: ["CoreInterface"]),
        .target(
            name: "CoreInterface",
            dependencies: []),        
        .testTarget(
            name: "CoreTests",
            dependencies: ["Core"]),
    ]
)
