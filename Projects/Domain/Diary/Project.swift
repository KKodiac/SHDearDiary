import ProjectDescription
import DependencyPlugin

let project = Project(
    name: "DomainDiary",
    packages: Project.Environment.packages,
    targets: [
        .target(
            name: "DomainDiary",
            destinations: Project.Environment.destinations,
            product: .staticLibrary,
            bundleId: "\(Project.Environment.bundlePrefix).Domain.Diary",
            deploymentTargets: Project.Environment.deploymentTarget,
            infoPlist: .extendingDefault(with: [:]),
            sources: ["Sources/**"],
            dependencies: Project.Environment.dependecies + [
                .project(target: "Core", path: .relativeToRoot("Projects/Core")),
            ]
        )
    ]
)
