import Foundation
import SwiftData

extension DiarySchemaV1 {
    @Model
    final class Dialogue: Identifiable, Equatable {
        var content: String
        var createAt: Date
        var role: Role
        
        init(
            content: String,
            role: Role,
            createAt: Date = .now
        ) {
            self.content = content
            self.role = role
            self.createAt = createAt
        }
    }
}
