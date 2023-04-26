// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CustomFontLoader",
    platforms: [
        .iOS(.v13), .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "CustomFontLoader",
            targets: ["CustomFontLoader"]),
    ],
    targets: [
        .target(
            name: "CustomFontLoader",
            dependencies: []),
    ]
)
