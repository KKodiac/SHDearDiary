import Foundation
import SwiftData

extension DiarySchemaV1 {
    @Model
    class Entry {
        let id: PersistentIdentifier
        let content: String
        let createdAt: Date
        
        @Relationship(deleteRule: .cascade)
        let prompts: [Prompt]
        
        init(id: PersistentIdentifier, content: String, createdAt: Date, prompts: [Prompt]) {
            self.id = id
            self.content = content
            self.createdAt = createdAt
            self.prompts = prompts
        }
    }
    
    @Model
    class Prompt {
        let id: PersistentIdentifier
        let role: Role
        let content: String
        let createdAt: Date
        
        init(id: PersistentIdentifier, role: Role, content: String, createdAt: Date) {
            self.id = id
            self.role = role
            self.content = content
            self.createdAt = createdAt
        }
        
        enum Role: Int, Codable {
            case user = 0
            case diary
        }
    }
}

