import ProjectDescription
import DependencyPlugin

let project = Project(
    name: "Database",
    packages: Project.Environment.packages,
    targets: [
        .target(
            name: "Database",
            destinations: Project.Environment.destinations,
            product: .staticLibrary,
            bundleId: "\(Project.Environment.bundlePrefix).Core.Database",
            deploymentTargets: Project.Environment.deploymentTarget,
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: Project.Environment.dependecies + [
                .project(target: "Shared", path: .relativeToRoot("./Projects/Shared")),
            ]
        ),
    ]
)
