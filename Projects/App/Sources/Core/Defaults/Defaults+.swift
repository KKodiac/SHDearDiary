import Foundation

extension UserDefaults {
    func string(forKey key: DefaultsKeys) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }
    
    func set(_ value: Any?, forKey defaultKey: DefaultsKeys) {
        return UserDefaults.standard.set(value, forKey: defaultKey.rawValue)
    }
    
    enum UserDefaultsError: Error {
        case failedFetch
    }
}
