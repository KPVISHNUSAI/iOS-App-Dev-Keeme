//
//  AuthenticationManager.swift
//  iOS App Dev Keeme
//
//  Created by user2 on 21/03/24.
//

import Foundation
import FirebaseAuth



//struct AuthDataResultModel {
//    let uid: String
//    let email: String?
//    let photoUrl: String?
//    let isAnonymous: Bool
//    
//    
//    init(user: User){
//        self.uid = user.uid
//        self.email = user.email
//        self.photoUrl = user.photoURL?.absoluteString
//        self.isAnonymous = user.isAnonymous
//    }
//}

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    let isAnonymous: Bool
    let firstName: String? // New property
    let lastName: String? // New property
    
    init(user: User){
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
        self.isAnonymous = user.isAnonymous
        self.firstName = nil
        self.lastName = nil
    }
    
    init(user: User, firstName: String?, lastName: String?) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
        self.isAnonymous = user.isAnonymous
        self.firstName = firstName
        self.lastName = lastName
    }
}

enum AuthProviderOptions: String {
    case email = "password"
    case google = "google.com"
    case apple = "apple.com"
}

enum AuthenticationError: Error {
    case invalidEmail
    case invalidPassword
    case confirmPasswordMismatch
    case invalidConfirmPassword
    case invalidUser
    case noFirstName
    case noLastName
}


final class AuthenticationManager {
    static let shared = AuthenticationManager()
    private init(){}
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
    
    
    // google.com
    // password
    func getProviders() throws -> [AuthProviderOptions] {
        guard let providerData = Auth.auth().currentUser?.providerData else {
            throw URLError(.badServerResponse)
        }
        var providers: [AuthProviderOptions] = []
        for provider in providerData{
            if let option = AuthProviderOptions(rawValue: provider.providerID) {
                providers.append(option)
            } else {
                assertionFailure("Provider option not found: \(provider.providerID)")
            }
            print(provider.providerID)
        }
        
        return providers
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func delete() async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badURL)
        }
        
        try await user.delete()
    }
}


// MARK: SIGN IN EMAIL
extension AuthenticationManager {
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    @discardableResult
    func createUser(email: String, password: String, firstName: String?, lastName: String?) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        
        // Update DBUser with firstName and lastName
        let user = DBUser(auth: AuthDataResultModel(user: authDataResult.user, firstName: firstName, lastName: lastName))
        
        // Create user in the database
        try await UserManager.shared.createNewUser(user: user)
        
        return AuthDataResultModel(user: authDataResult.user, firstName: firstName, lastName: lastName)
    }

    
    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func updatePassword(password: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        try await user.updatePassword(to: password)
    }
    
    func updateEmail(email: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        try await user.updateEmail(to: email)
    }
}


// MARK: SIGN IN SSO
extension AuthenticationManager {
    
    @discardableResult
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await signIn(credential: credential)
    }
    
    @discardableResult
    func signInWithApple(tokens: SignInWithAppleResult) async throws -> AuthDataResultModel {
        let credential = OAuthProvider.credential(withProviderID: AuthProviderOptions.apple.rawValue, idToken: tokens.token, rawNonce: tokens.nonce)
        
        return try await signIn(credential: credential)
    }
    
    func signIn(credential: AuthCredential) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: authDataResult.user)
    }
}

// MARK: SIGN IN ANONYMOUS
extension AuthenticationManager {
    @discardableResult
    func signInAnonymous() async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signInAnonymously()
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func  linkEmail(email: String, password: String) async throws -> AuthDataResultModel {
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        return try await linkCredential(credential: credential)
    }
    
    func  linkGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await linkCredential(credential: credential)
    }

    
    func  linkApple(tokens: SignInWithAppleResult) async throws -> AuthDataResultModel {
        let credential = OAuthProvider.credential(withProviderID: AuthProviderOptions.apple.rawValue, idToken: tokens.token, rawNonce: tokens.nonce)
        return try await linkCredential(credential: credential)
    }
    
    private func linkCredential(credential: AuthCredential) async throws -> AuthDataResultModel{
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badURL)
        }
        let authDataResult = try await  user.link(with: credential)
        return AuthDataResultModel(user: authDataResult.user)
    }

}

