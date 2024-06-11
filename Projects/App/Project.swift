import ProjectDescription
import DependencyPlugin

let project = Project(
    name: "App",
    organizationName: "bibumtiger",
    packages: Project.Environment.packages,
    settings: .settings(configurations: [
        .debug(name: "Debug", xcconfig: .relativeToRoot("Configs/App.xcconfig")),
        .release(name: "Release", xcconfig: .relativeToRoot("Configs/App.xcconfig"))
    ]),
    targets: [
        .target(
            name: "\(Project.Environment.appName)App",
            destinations: Project.Environment.destinations,
            product: .app,
            bundleId: "\(Project.Environment.bundlePrefix).\(Project.Environment.appName).App",
            infoPlist: .extendingDefault(with: Project.Secrets.appInfoPList),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            entitlements: .dictionary([
                "com.apple.developer.applesignin": .array(["Default"])
            ]),
            dependencies: Project.Environment.dependecies + [
                .project(target: "Feature", path: .relativeToRoot("Projects/Feature")),
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
