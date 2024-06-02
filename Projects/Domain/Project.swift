import ProjectDescription
import DependencyPlugin

let project = Project(
    name: "Domain",
    packages: Project.Environment.packages,
    targets: [
        .target(
            name: "Domain",
            destinations: Project.Environment.destinations,
            product: .staticLibrary,
            bundleId: "\(Project.Environment.bundlePrefix).Domain",
            deploymentTargets: Project.Environment.deploymentTarget,
            infoPlist: .extendingDefault(with: [:]),
            sources: ["Sources/**"],
            dependencies: Project.Environment.dependecies + [
                .project(target: "DomainDiary", path: .relativeToCurrentFile("./Diary")),
                .project(target: "DomainUser", path: .relativeToCurrentFile("./User")),
            ]
        )
    ]
)
