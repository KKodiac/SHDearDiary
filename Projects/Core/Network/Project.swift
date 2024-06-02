import ProjectDescription
import DependencyPlugin

let project = Project(
    name: "Network",
    packages: Project.Environment.packages,
    targets: [
        .target(
            name: "Network",
            destinations: Project.Environment.destinations,
            product: .staticLibrary,
            bundleId: "\(Project.Environment.bundlePrefix).Data.Network",
            deploymentTargets: Project.Environment.deploymentTarget,
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: Project.Environment.dependecies + [
                .project(target: "Shared", path: .relativeToRoot("./Projects/Shared")),
            ]
        ),
    ]
)
