// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "GTMToolFinder",
    products: [
        .library(name: "GTMToolFinder", targets: ["GTMToolFinder"]),
        .executable(name: "gtm-tool-finder", targets: ["gtm-tool-finder"])
    ],
    targets: [
        .target(name: "GTMToolFinder"),
        .executableTarget(name: "gtm-tool-finder", dependencies: ["GTMToolFinder"])
    ]
)
