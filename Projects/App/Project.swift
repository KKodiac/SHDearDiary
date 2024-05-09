import ProjectDescription
import DependencyPlugin

let project = Project(
    name: "\(Project.Environment.appName)App",
    targets: [
        .target(
            name: "\(Project.Environment.appName)App",
            destinations: Project.Environment.destinations,
            product: .app,
            bundleId: "\(Project.Environment.bundlePrefix).\(Project.Environment.appName).App",
            infoPlist: .extendingDefault(
                with: Project.Secrets.appInfoPList
            ),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            entitlements: .dictionary([
                "com.apple.developer.applesignin": .array(["Default"])
            ]),
            dependencies: [
                .project(target: "Shared", path: .relativeToRoot("./Projects/Shared")),
            ]
        ),
        .target(
            name: "\(Project.Environment.appName)Tests",
            destinations: Project.Environment.destinations,
            product: .unitTests,
            bundleId: "\(Project.Environment.bundlePrefix).\(Project.Environment.appName).Test",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "\(Project.Environment.appName)App")]
        ),
    ]
)
