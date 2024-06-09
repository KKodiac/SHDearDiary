// swift-tools-version: 5.9
import PackageDescription

#if TUIST
import ProjectDescription

let packageSettings = PackageSettings(
    productTypes: [
        "ComposableArchitecture": .framework,
        "ComposableArchitectureMacros": .framework,
        "Moya": .framework,
        "SwiftUICalendar": .framework,
        "Firebase": .framework,
        "FirebaseAuth": .framework,
        "GoogleSignIn": .framework,
        "GoogleSignInSwift": .framework,
    ]
)

#endif

let package = Package(
    name: "PackageName",
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", from: "1.7.2"),
        .package(url: "https://github.com/Moya/Moya.git", from: "15.0.3"),
        .package(url: "https://github.com/GGJJack/SwiftUICalendar", from: "0.1.13"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk", from: "10.20.0"),
        .package(url: "https://github.com/google/GoogleSignIn-iOS", from: "7.0.0"),
    ]
)
