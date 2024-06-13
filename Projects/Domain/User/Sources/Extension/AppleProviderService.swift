import AuthenticationServices
import Dependencies
import Firebase
import Shared
import SwiftUI

extension DependencyValues {
    public var appleProvider: AppleProviderService {
        get { self[AppleProviderService.self] }
        set { self[AppleProviderService.self] = newValue }
    }
}

public final class AppleProviderService {
    enum AppleProviderError: Error {
        case invalidRawNonce
        case invalidCredentialToken
        case invalidAuthorizedUser
    }
    
    public init() { }
    
    public func execute(_ controller: AuthorizationController) async throws -> User {
        async let request = makeAuthorizationRequest()
        let result = try await controller.performRequest(request)
        var data: AuthDataResult? = nil
        if case let .appleID(credential) = result {
            guard let token = credential.identityToken,
                  let tokenString = String(data: token, encoding: .utf8)
            else { throw AppleProviderError.invalidCredentialToken }
            let credential = OAuthProvider.appleCredential(
                withIDToken: tokenString,
                rawNonce: randomNonceString(),
                fullName: credential.fullName
            )
            data = try await requestFirebaseSignIn(credential)
        }
        guard let data = data else { throw AppleProviderError.invalidAuthorizedUser }
        return User(
            uid: data.user.uid,
            email: data.user.email,
            name: data.user.displayName,
            isNewUser: data.additionalUserInfo?.isNewUser
        )
    }
    
    private func makeAuthorizationRequest() -> ASAuthorizationAppleIDRequest {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        return request
    }
    
    private func requestFirebaseSignIn(_ credential: AuthCredential) async throws -> AuthDataResult {
        let firebase = Firebase.Auth.auth()
        return try await firebase.signIn(with: credential)
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            fatalError(
                "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
        }
        
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        
        let nonce = randomBytes.map { byte in
            charset[Int(byte) % charset.count]
        }
        
        return String(nonce)
    }
    
}

extension AppleProviderService: DependencyKey {
    public static var liveValue: AppleProviderService = AppleProviderService()
}
