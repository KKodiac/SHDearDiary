import ProjectDescription
import DependencyPlugin

let project = Project(
    name: "Shared",
    packages: [],
    targets: [
        .target(
            name: "Shared",
            destinations: Project.Environment.destinations,
            product: .staticLibrary,
            bundleId: "\(Project.Environment.bundlePrefix).Shared",
            deploymentTargets: Project.Environment.deploymentTarget,
            infoPlist: .default,
            sources: ["Sources/*"],
            dependencies: [
                .project(target: "UserInterface", path: .relativeToCurrentFile("./UI")),
            ]
        ),
    ]
)
