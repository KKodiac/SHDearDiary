import SwiftData

enum DiarySchemaV1: VersionedSchema {
    public static var versionIdentifier = Schema.Version(1, 0 ,0)
    
    public static var models: [any PersistentModel.Type] {
        [DiarySchemaV1.Entry.self, DiarySchemaV1.Dialogue.self]
    }
}
