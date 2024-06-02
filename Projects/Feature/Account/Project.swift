import ProjectDescription
import DependencyPlugin

let project = Project(
    name: "Account",
    packages: Project.Environment.packages,
    targets: [
        .target(
            name: "Account",
            destinations: Project.Environment.destinations,
            product: .staticLibrary,
            bundleId: "\(Project.Environment.bundlePrefix).Feature.Account",
            deploymentTargets: Project.Environment.deploymentTarget,
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: Project.Environment.dependecies + [
                .project(target: "Domain", path: .relativeToRoot("Projects/Domain")),
            ]
        ),
        .target(
            name: "AccountApp",
            destinations: Project.Environment.destinations,
            product: .app,
            bundleId: "\(Project.Environment.bundlePrefix).Feature.Account.App",
            deploymentTargets: Project.Environment.deploymentTarget,
            infoPlist: .default,
            sources: ["Example/Sources/*"],
            dependencies: [
                .target(name: "Account", condition: .when(.all))
            ]
        ),
    ]
)
