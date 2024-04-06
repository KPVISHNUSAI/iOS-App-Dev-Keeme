//
//  AuthenticationView.swift
//  iOS App Dev Keeme
//
//  Created by user2 on 21/03/24.
//

import SwiftUI
import GoogleSignInSwift
import GoogleSignIn



@MainActor
final class AuthenticationViewModel: ObservableObject {
    let signInAppleHelper = SignInAppleHelper()
    
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        let authDataResult = try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
        let user = DBUser(auth: authDataResult)
        try await UserManager.shared.createNewUser(user: user)

    }
    
    func signInApple() async throws {
        let helper = SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        let authDataResult = try await AuthenticationManager.shared.signInWithApple(tokens: tokens)
        let user = DBUser(auth: authDataResult)
        try await UserManager.shared.createNewUser(user: user)
    }
    
    func signInAnonymous() async throws {
        let authDataResult = try await AuthenticationManager.shared.signInAnonymous()
        let user = DBUser(auth: authDataResult)
        try await UserManager.shared.createNewUser(user: user)
//        try await UserManager.shared.createNewUser(auth: authDataResult)
    }
}









struct AuthenticationView: View {
    @StateObject private var viewModel = AuthenticationViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        ScrollView {
            VStack     {
                // MARK: Anonymous SignIn
//                Button(action: {
//                    Task{
//                        do {
//                            try await viewModel.signInAnonymous()
//                            showSignInView = false
//                        } catch {
//                            print(error)
//                        }
//                    }
//                    
//                }, label: {
//                    Text("Sign In Anonymously")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .frame(height: 55)
//                        .frame(maxWidth: .infinity)
//                        .background(Color.orange)
//                        .cornerRadius(10)
//                })
                
                
                //            NavigationLink {
                //                LoginPage1(showSignInView: $showSignInView)
                //            } label : {
                //                Text("Sign In with Email")
                //                    .font(.headline)
                //                    .foregroundColor(.white)
                //                    .frame(height: 55)
                //                    .frame(maxWidth: .infinity)
                //                    .background(Color.blue)
                //                    .cornerRadius(10)
                //            }
                
                LoginPage1(showSignInView: $showSignInView)
                
                Text("or")
                Divider()
                
                GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)){
                    Task{
                        do {
                            try await viewModel.signInGoogle()
                            showSignInView = false
                        } catch {
                            print(error)
                        }
                    }
                }
                
                
                Button(action: {
                    Task{
                        do {
                            try await viewModel.signInApple()
                            showSignInView = false
                        } catch {
                            print(error)
                        }
                    }
                }, label: {
                    SignInWithAppleButtonViewRepresentable(type: .default, style: .black)
                        .allowsHitTesting(false)
                })
                .frame(height: 55)
                
                Button(action: {
                    Task{
                        do {
                            try await viewModel.signInAnonymous()
                            showSignInView = false
                        } catch {
                            print(error)
                        }
                    }
                    
                }, label: {
                    Text("Sign In Anonymously")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .cornerRadius(10)
                })
                
                Spacer()
            }
            .padding()
            
        }
        .navigationTitle("KEEME")
    }
}

#Preview {
    AuthenticationView(showSignInView: .constant(false))
}

