import ComposableArchitecture
import SwiftUI
import OSLog

@main
struct DearDiaryApp: App {
    private let logger = Logger(subsystem: DearDiaryApp.subsystem, category: "App")
    var store: StoreOf<AppCore> = .init(initialState: AppCore.State()) {
        AppCore()
    }
    
    var body: some Scene {
        WindowGroup {
            AppView(store: store)
        }
    }
}

extension DearDiaryApp {
    static let subsystem = Bundle.main.bundleIdentifier ?? "DearDiaryApp"
}
