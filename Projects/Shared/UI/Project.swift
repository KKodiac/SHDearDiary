import ProjectDescription
import DependencyPlugin

let project = Project(
    name: "UserInterface",
    targets: [
        .target(
            name: "UserInterface",
            destinations: Project.Environment.destinations,
            product: .staticLibrary,
            bundleId: "\(Project.Environment.bundlePrefix).\(Project.Environment.appName).Shared.UserInterface",
            deploymentTargets: Project.Environment.deploymentTarget,
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: ["Resources/**"]
        ),
    ],
    resourceSynthesizers: [
        .assets(),
        .fonts()
    ]
)
