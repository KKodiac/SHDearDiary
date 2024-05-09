import Foundation
import ProjectDescription

public extension Project {
	enum Environment {
		public static let appName = "DearDiary"
		public static let destinations: Destinations = .iOS
		public static let deploymentTarget = DeploymentTargets.iOS("17.0")
		public static let bundlePrefix = "com.bibumtiger"
		public static let featureProductType = ProjectDescription.Product.staticLibrary
        public static let dependecies: [TargetDependency] = [
            .package(product: "ComposableArchitecture", type: .runtime),
            .package(product: "FirebaseAuth", type: .runtime),
            .package(product: "GoogleSignIn", type: .runtime),
            .package(product: "GoogleSignInSwift", type: .runtime),
            .package(product: "Moya", type: .runtime),
            .package(product: "SwiftUICalendar", type: .runtime)
        ]
	}
}
