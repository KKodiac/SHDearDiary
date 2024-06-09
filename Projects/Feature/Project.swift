import ProjectDescription
import DependencyPlugin

let project = Project(
    name: "Feature",
    packages: Project.Environment.packages,
    targets: [
        .target(
            name: "Feature",
            destinations: Project.Environment.destinations,
            product: .staticLibrary,
            bundleId: "\(Project.Environment.bundlePrefix).Feature",
            deploymentTargets: Project.Environment.deploymentTarget,
            infoPlist: .default,
            sources: ["Sources/*"],
            dependencies: Project.Environment.dependecies + [
                .project(target: "Account", path: .relativeToCurrentFile("Account")),
                .project(target: "Diary", path: .relativeToCurrentFile("Diary")),
                .project(target: "Setting", path: .relativeToCurrentFile("Setting")),
            ]
        ),
    ]
)
