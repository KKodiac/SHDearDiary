import ProjectDescription
import DependencyPlugin

let project = Project(
    name: "Setting",
    packages: Project.Environment.packages,
    targets: [
        .target(
            name: "Setting",
            destinations: Project.Environment.destinations,
            product: .staticLibrary,
            bundleId: "\(Project.Environment.bundlePrefix).Feature.Setting",
            deploymentTargets: Project.Environment.deploymentTarget,
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: Project.Environment.dependecies + [
                .project(target: "Domain", path: .relativeToRoot("./Projects/Domain")),
            ]
        ),
    ]
)
