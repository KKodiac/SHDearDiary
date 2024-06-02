import ProjectDescription
import DependencyPlugin

let project = Project(
    name: "KeyValueStore",
    packages: Project.Environment.packages,
    targets: [
        .target(
            name: "KeyValueStore",
            destinations: Project.Environment.destinations,
            product: .staticLibrary,
            bundleId: "\(Project.Environment.bundlePrefix).Data.KeyValueStore",
            deploymentTargets: Project.Environment.deploymentTarget,
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: Project.Environment.dependecies + [
                .project(target: "Shared", path: .relativeToRoot("./Projects/Shared")),
            ]
        ),
    ]
)
