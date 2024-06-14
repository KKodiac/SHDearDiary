import Foundation
import SwiftData

typealias DiarySchema = DiarySchemaV1

typealias DiaryEntry = DiarySchema.Entry
typealias DiaryDialogue = DiarySchema.Dialogue

enum DiaryMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [DiarySchemaV1.self]
    }
    
    static var stages: [MigrationStage] { [] }
}
