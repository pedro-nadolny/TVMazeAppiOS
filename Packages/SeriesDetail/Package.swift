// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "SeriesDetail",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "SeriesDetail",
            targets: ["SeriesDetail"]),
        .library(
            name: "SeriesDetailInterface",
            targets: ["SeriesDetailInterface"]),
    ],
    dependencies: [
        .package(path: "../Core"),
        .package(path: "../LayoutExtensions"),
        .package(path: "../TVMazeServices")
    ],
    targets: [
        .target(
            name: "SeriesDetailInterface",
            dependencies: [
                .product(name: "CoreInterface", package: "Core"),
                .product(name: "TVMazeServicesInterface", package: "TVMazeServices")
            ]),
        .target(
            name: "SeriesDetail",
            dependencies: [
                "SeriesDetailInterface",
                "LayoutExtensions",
                .product(name: "CoreInterface", package: "Core"),
                .product(name: "TVMazeServicesInterface", package: "TVMazeServices")
            ]),
        .testTarget(
            name: "SeriesDetailTests",
            dependencies: ["SeriesDetail"]),
    ]
)
