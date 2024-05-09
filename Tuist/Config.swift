import ProjectDescription

let config = Config(
    plugins: [
        .local(path: .relativeToRoot("Tuist/Plugins/DependencyPlugin"))
    ], 
    generationOptions: .options(enforceExplicitDependencies: true)
)
