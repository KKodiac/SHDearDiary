import ProjectDescription

let fileName: Template.Attribute = .required("name")

let domain = Template(
    description: "New Template for regular sources files.",
    attributes: [
            fileName
    ],
    items: [
        .file(path: "\(fileName).swift", templatePath: "File.stencil")
    ]
)
