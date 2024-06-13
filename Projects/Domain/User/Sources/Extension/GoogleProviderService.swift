import Dependencies
import Firebase
import GoogleSignIn
import GoogleSignInSwift
import Shared
import SwiftUI

extension DependencyValues {
    public var googleProvider: GoogleProviderService {
        get { self[GoogleProviderService.self] }
        set { self[GoogleProviderService.self] = newValue }
    }
}

public final class GoogleProviderService {
    enum GoogleProviderError: Error {
        case invalidRootViewController
        case invalidIdToken
        case invalidFirebaseApp
        case invalidClientId
    }
    
    private var configured: Bool = false
    
    public init() { }
    
    public func initialize() {
        if !configured {
            FirebaseApp.configure()
            configured.toggle()
        }
    }
    
    public func handleURL(_ url: URL) {
        GIDSignIn.sharedInstance.handle(url)
    }
    
    public func execute() async throws -> User {
        let credential = try await makeAuthorizationRequest()
        let data = try await requestFirebaseSignIn(credential)
        
        return User(
            uid: data.user.uid,
            email: data.user.email,
            name: data.user.displayName,
            isNewUser: data.additionalUserInfo?.isNewUser
        )
    }
    
    @MainActor
    private func makeAuthorizationRequest() async throws -> AuthCredential {
        guard let controller = await (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .windows.first?.rootViewController else {
            throw GoogleProviderError.invalidRootViewController
        }
        
        guard let app = FirebaseApp.app() else { throw GoogleProviderError.invalidFirebaseApp }
        guard let clientId = app.options.clientID else { throw GoogleProviderError.invalidClientId }
        let provider = GIDSignIn.sharedInstance
        provider.configuration = GIDConfiguration(clientID: clientId)
        let result = try await provider.signIn(withPresenting: controller)
        guard let token = result.user.idToken else {
            throw GoogleProviderError.invalidIdToken
        }
        let tokenString = result.user.accessToken.tokenString
        let credential = GoogleAuthProvider.credential(
            withIDToken: token.tokenString,
            accessToken: tokenString
        )
        return credential
    }
    
    
    private func requestFirebaseSignIn(_ credential: AuthCredential) async throws -> AuthDataResult {
        let firebase = Firebase.Auth.auth()
        return try await firebase.signIn(with: credential)
    }
}

extension GoogleProviderService: DependencyKey {
    public static var liveValue: GoogleProviderService = GoogleProviderService()
}
