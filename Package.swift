// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "countdownclocks",
    products: [
        .library(name: "countdownclocks", targets: ["App"]),
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),

        // Leaf for pages
        .package(url: "https://github.com/vapor/leaf.git", from: "3.0.0"),

        // 🐘 Non-blocking, event-driven Swift client for PostgreSQL.
        .package(url: "https://github.com/vapor/postgresql.git", from: "1.4.0"),
        .package(url: "https://github.com/vapor/fluent-postgresql.git", from: "1.0.0"),
    ],
    targets: [
        .target(name: "App", dependencies: ["Leaf", "Vapor", "PostgreSQL", "FluentPostgreSQL"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)
