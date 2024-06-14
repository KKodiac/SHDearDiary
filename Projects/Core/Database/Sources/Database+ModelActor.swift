import Foundation
import SwiftData

extension Database {
    @ModelActor
    public actor BackgroundDatabaseActor {
        private var context: ModelContext {
            modelExecutor.modelContext.autosaveEnabled = true
            return modelExecutor.modelContext
        }
        
        public func fetchOne<T: PersistentModel>(by id: PersistentIdentifier) -> T? {
            return self[id, as: T.self]
        }
        
        public func fetchData<T: PersistentModel>(
            predicate: Predicate<T>? = nil,
            sortBy: [SortDescriptor<T>] = []
        ) throws -> [T] {
            let fetchDescriptor = FetchDescriptor<T>(predicate: predicate, sortBy: sortBy)
            let list: [T] = try context.fetch(fetchDescriptor)
            return list
        }
        
        public func fetch<T: PersistentModel>(
            predicate: Predicate<T>? = nil,
            sortBy: [SortDescriptor<T>] = [],
            fetchLimit: Int
        ) throws -> [T] {
            var fetchDescriptor = FetchDescriptor<T>(predicate: predicate, sortBy: sortBy)
            fetchDescriptor.fetchLimit = fetchLimit
            let list: [T] = try context.fetch(fetchDescriptor)
            return list
        }
        
        public func fetchCount<T: PersistentModel>(
            predicate: Predicate<T>? = nil,
            sortBy: [SortDescriptor<T>] = []
        ) throws -> Int {
            let fetchDescriptor = FetchDescriptor<T>(predicate: predicate, sortBy: sortBy)
            let count = try context.fetchCount(fetchDescriptor)
            return count
        }
        
        public func insertAll<T: PersistentModel>(data: [T]) {
            data.forEach {
                self.insert(data: $0)
            }
        }
        
        public func insert<T: PersistentModel>(data: T) {
            context.insert(data)
        }
        
        public func save() throws {
            if context.hasChanges {
                try context.save()
            }
        }
        
        public func remove<T: PersistentModel>(predicate: Predicate<T>? = nil) throws {
            try context.delete(model: T.self, where: predicate)
        }
        
        public func saveAndInsertIfNeeded<T: PersistentModel>(
            data: T,
            predicate: Predicate<T>
        ) throws {
            let descriptor = FetchDescriptor<T>(predicate: predicate)
            let context = data.modelContext ?? context
            let savedCount = try context.fetchCount(descriptor)
            
            if savedCount == 0 {
                context.insert(data)
            }
            try context.save()
        }
    }
}
