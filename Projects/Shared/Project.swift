import ProjectDescription
import DependencyPlugin

let project = Project(
    name: "Shared",
    packages: [
        .remote(url: "https://github.com/pointfreeco/swift-composable-architecture.git", requirement: .upToNextMajor(from: "1.7.2")),
        .remote(url: "https://github.com/Moya/Moya.git", requirement: .upToNextMajor(from: "15.0.3")),
        .remote(url: "https://github.com/GGJJack/SwiftUICalendar", requirement: .exact("0.1.13")),
        .remote(url: "https://github.com/firebase/firebase-ios-sdk", requirement: .upToNextMajor(from: "10.20.0")),
        .remote(url: "https://github.com/google/GoogleSignIn-iOS", requirement: .exact("7.0.0"))
    ],
    targets: [
        .target(
            name: "Shared",
            destinations: Project.Environment.destinations,
            product: .staticLibrary,
            bundleId: "\(Project.Environment.bundlePrefix).Shared",
            deploymentTargets: Project.Environment.deploymentTarget,
            infoPlist: .default,
            sources: ["Sources/*"],
            dependencies: Project.Environment.dependecies + [
                .project(target: "UserInterface", path: .relativeToCurrentFile("./UI")),
                // .external(name: "ComposableArchitecture", condition: .when(.all)),
                // .external(name: "FirebaseAuth", condition: .when(.all)),
                // .external(name: "GoogleSignIn", condition: .when(.all)),
            ]
        ),
    ]
)
