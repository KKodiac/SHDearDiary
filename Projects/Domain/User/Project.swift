import ProjectDescription
import DependencyPlugin

let project = Project(
    name: "DomainUser",
    packages: Project.Environment.packages,
    targets: [
        .target(
            name: "DomainUser",
            destinations: Project.Environment.destinations,
            product: .staticLibrary,
            bundleId: "\(Project.Environment.bundlePrefix).Domain.User",
            deploymentTargets: Project.Environment.deploymentTarget,
            infoPlist: .extendingDefault(with: [:]),
            sources: ["Sources/**"],
            dependencies: Project.Environment.dependecies + [
                .project(target: "Core", path: .relativeToRoot("Projects/Core")),
            ]
        )
    ]
)
