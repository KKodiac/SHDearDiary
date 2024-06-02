import ProjectDescription
import DependencyPlugin

let project = Project(
    name: "RelationalStore",
    packages: Project.Environment.packages,
    targets: [
        .target(
            name: "RelationalStore",
            destinations: Project.Environment.destinations,
            product: .staticLibrary,
            bundleId: "\(Project.Environment.bundlePrefix).Data.RelationalStore",
            deploymentTargets: Project.Environment.deploymentTarget,
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: Project.Environment.dependecies + [
                .project(target: "Shared", path: .relativeToRoot("./Projects/Shared")),
            ]
        ),
    ]
)
