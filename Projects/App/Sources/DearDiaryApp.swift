import ComposableArchitecture
import SwiftUI
import OSLog

@main
struct DearDiaryApp: App {
    private let logger = Logger(subsystem: DearDiaryApp.subsystem, category: "App")
    
    var body: some Scene {
        WindowGroup {
            AppView(store: .init(initialState: AppCore.State()) {
                AppCore()
            })
        }
    }
}

extension DearDiaryApp {
    static let subsystem = Bundle.main.bundleIdentifier ?? "DearDiaryApp"
}
