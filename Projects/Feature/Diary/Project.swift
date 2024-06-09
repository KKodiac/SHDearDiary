import ProjectDescription
import DependencyPlugin

let project = Project(
    name: "Diary",
    packages: Project.Environment.packages,
    targets: [
        .target(
            name: "Diary",
            destinations: Project.Environment.destinations,
            product: .staticLibrary,
            bundleId: "\(Project.Environment.bundlePrefix).Feature.Diary",
            deploymentTargets: Project.Environment.deploymentTarget,
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: Project.Environment.dependecies + [
                .project(target: "Domain", path: .relativeToRoot("./Projects/Domain")),
            ]
        ),
    ]
)
