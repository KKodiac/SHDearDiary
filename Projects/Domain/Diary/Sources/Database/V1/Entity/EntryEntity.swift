import Foundation
import SwiftData

extension DiarySchemaV1 {
    @Model
    final class Entry: Identifiable {
        @Attribute(.unique)
        var id: UUID
        var title: String
        var content: String
        
        @Relationship(deleteRule: .cascade)
        var dialogue: [Dialogue]
        var createAt: Date
        
        init(
            id: UUID = UUID(),
            title: String,
            content: String,
            dialogue: [Dialogue] = [],
            createAt: Date = .now
        ) {
            self.id = id
            self.title = title
            self.content = content
            self.dialogue = dialogue
            self.createAt = createAt
        }
    }
}
