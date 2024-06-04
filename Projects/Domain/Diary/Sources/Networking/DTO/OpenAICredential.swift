import Foundation

struct OpenAICredential: Decodable {
    let openAIToken: String
    let assistantID: String
    
    enum CodingKeys: String, CodingKey {
        case openAIToken = "OpenAIToken"
        case assistantID = "AssistantID"
    }
}

enum PropertyReader {
    static var assistantId: String {
        guard let openAIProperty = Bundle.main.path(forResource: "DearDiaryApp-Info", ofType: "plist"),
              let data = try? Data(contentsOf: URL(filePath: openAIProperty)),
              let dataSource = try? PropertyListDecoder().decode(OpenAICredential.self, from: data) else {
            fatalError("[Credential ERROR] Unable to read fomr Property List")
        }
        return dataSource.assistantID
    }
    
    static var openAIToken: String {
        guard let openAIProperty = Bundle.main.path(forResource: "DearDiaryApp-Info", ofType: "plist"),
              let data = try? Data(contentsOf: URL(filePath: openAIProperty)),
              let dataSource = try? PropertyListDecoder().decode(OpenAICredential.self, from: data) else {
            fatalError("[Credential ERROR] Unable to read from Property List")
        }
        return dataSource.openAIToken
    }
}
