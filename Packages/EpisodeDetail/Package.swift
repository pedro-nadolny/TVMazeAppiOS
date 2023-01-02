// swift-tools-version: 5.7


import PackageDescription

let package = Package(
    name: "EpisodeDetail",
    products: [
        .library(
            name: "EpisodeDetail",
            targets: ["EpisodeDetail"]),
        .library(
            name: "EpisodeDetailInterface",
            targets: ["EpisodeDetailInterface"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "EpisodeDetail",
            dependencies: ["EpisodeDetailInterface"]),
        .target(
            name: "EpisodeDetailInterface",
            dependencies: []),
        .testTarget(
            name: "EpisodeDetailTests",
            dependencies: ["EpisodeDetail"]),
    ]
)
