import Foundation

public struct Diary: Codable {
    var name: String
    var personality: Personality
}

public enum Personality: String, CaseIterable, Codable {
    case basic
    case friendly
    case none
}
