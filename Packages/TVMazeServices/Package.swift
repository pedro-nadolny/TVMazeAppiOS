// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TVMazeServices",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "TVMazeServices",
            targets: ["TVMazeServices"]),
        .library(
            name: "TVMazeServicesInterface",
            targets: ["TVMazeServices"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "TVMazeServices",
            dependencies: ["TVMazeServicesInterface"]),
        .target(
            name: "TVMazeServicesInterface",
            dependencies: []),
        .testTarget(
            name: "TVMazeServicesTests",
            dependencies: ["TVMazeServices"]),
    ]
)
 
