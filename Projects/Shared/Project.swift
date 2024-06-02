import ProjectDescription
import DependencyPlugin

let project = Project(
    name: "Shared",
    packages: Project.Environment.packages,
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
                .project(target: "UserInterface", path: .relativeToCurrentFile("UI")),
                .project(target: "ExternalDependencies", path: .relativeToCurrentFile("ExternalDependencies")),
            ]
        ),
    ]
)
