// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "JsonTag",
    products: [
        .library(name: "JsonTag", targets: ["JsonTag"]),
    ],
    targets: [
        .target(name: "JsonTag"),
        .testTarget(name: "JsonTagTests", dependencies: ["JsonTag"]),
    ]
)
