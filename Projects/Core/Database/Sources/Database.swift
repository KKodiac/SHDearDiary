import Dependencies
import Foundation
import SwiftData
import OSLog

public class Database {
    private var actor: BackgroundDatabaseActor
    
    public init(_ container: ModelContainer) {
        self.actor = BackgroundDatabaseActor(modelContainer: container)
    }
    
    public func fetchOne<T: PersistentModel>(by id: PersistentIdentifier) async -> T? {
        return await actor.fetchOne(by: id)
    }
    
    public func fetch<T: PersistentModel>(for model: T.Type, by predicate: Predicate<T>) async throws -> [T] {
        return try await actor.fetchData(predicate: predicate)
    }
    
    public func fetch<T: PersistentModel>(for model: T.Type, by predicate: Predicate<T>, sortBy: [SortDescriptor<T>] = [], fetchSize: Int = 512) async throws -> [T] {
        return try await actor.fetch(predicate: predicate, sortBy: [], fetchLimit: fetchSize)
    }
    
    public func fetch<T: PersistentModel>(for model: T.Type, sortBy: [SortDescriptor<T>] = [], fetchSize: Int = 5000) async throws -> [T] {
        return try await actor.fetch(predicate: nil, sortBy: [], fetchLimit: fetchSize)
    }
    
    public func fetchAll<T: PersistentModel>(for model: T.Type, sortBy: [SortDescriptor<T>] = []) async throws -> [T] {
        return try await actor.fetchData(predicate: nil, sortBy: sortBy)
    }
    
    public func insert<T: PersistentModel>(_ model: T) async throws -> Void {
        Task.detached {
            if model.hasChanges {
                await self.actor.insert(data: model)
            }
        }
    }
    
    public func insert<T: PersistentModel>(_ models: [T]) async throws -> Void {
        Task.detached {
            await self.actor.insertAll(data: models.filter { $0.hasChanges })
        }
    }
    
    
    public enum DatabaseError: Error {
        case invalidContainer
    }
}
