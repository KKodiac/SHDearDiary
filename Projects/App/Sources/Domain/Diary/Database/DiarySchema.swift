import Foundation
import SwiftData

typealias DiarySchema = DiarySchemaV1

struct DiarySchemaV1: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 0, 0)
    
    static var models: [any PersistentModel.Type] = [Entry.self, Prompt.self]
}

struct DiaryMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] = [
        DiarySchemaV1.self
    ]
    
    static var stages: [MigrationStage] = []
}
