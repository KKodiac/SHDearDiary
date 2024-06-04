import ProjectDescription
import DependencyPlugin

let project = Project(
    name: "Core",
    packages: Project.Environment.packages,
    targets: [
        .target(
            name: "Core",
            destinations: Project.Environment.destinations,
            product: .staticLibrary,
            bundleId: "\(Project.Environment.bundlePrefix).Core",
            deploymentTargets: Project.Environment.deploymentTarget,
            infoPlist: .default,
            sources: ["Sources/*"],
            dependencies: Project.Environment.dependecies + [
                .project(target: "Database", path: .relativeToCurrentFile("Database")),
                .project(target: "Network", path: .relativeToCurrentFile("Network")),
                .project(target: "Shared", path: .relativeToRoot("Projects/Shared")),
            ]
        ),
    ]
)
