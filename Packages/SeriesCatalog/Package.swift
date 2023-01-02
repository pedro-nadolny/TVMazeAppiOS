// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "SeriesCatalog",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "SeriesCatalog",
            targets: ["SeriesCatalog"]),
        .library(
            name: "SeriesCatalogInterface",
            targets: ["SeriesCatalogInterface"]),
    ],
    dependencies: [
        .package(path: "../Core"),
        .package(path: "../LayoutExtensions"),
        .package(path: "../TVMazeServices"),
        .package(path: "../SeriesDetail")
    ],
    targets: [
        .target(
            name: "SeriesCatalogInterface",
            dependencies: [
                .product(name: "CoreInterface", package: "Core"),
                .product(name: "TVMazeServicesInterface", package: "TVMazeServices"),
                .product(name: "SeriesDetailInterface", package: "SeriesDetail")
            ]),
        .target(
            name: "SeriesCatalog",
            dependencies: [
                "SeriesCatalogInterface",
                "LayoutExtensions",
                .product(name: "CoreInterface", package: "Core"),
                .product(name: "TVMazeServicesInterface", package: "TVMazeServices"),
                .product(name: "SeriesDetailInterface", package: "SeriesDetail")
            ]),
        .testTarget(
            name: "SeriesCatalogTests",
            dependencies: ["SeriesCatalog"]),
     ]
)
