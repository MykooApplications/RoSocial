//
//  AuthViewModel.swift
//  Rocial
//
//  Created by Roshan Mykoo on 9/14/22.
//

import Foundation

@MainActor
class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var email = ""
    @Published var password = ""
    
    private let authService = AuthService()
    
    init() {
        authService.$user.assign(to: &$user)
    }
    
    func signIn() {
        Task {
            do {
                try await authService.signIn(email: email, password: password)
            } catch {
                print("[]")
            }
        }
    }
    
    func makeSignInViewModel() -> SignInViewModel {
        return SignInViewModel(action: authService.signIn(email:password:))
    }
     
    func makeCreateAccountViewModel() -> CreateAccountViewModel {
        return CreateAccountViewModel(action: authService.createAccount(name:email:password:))
    }
    
    
}

extension AuthViewModel {
    class SignInViewModel: FormViewModel<(email: String, password: String)> {
        convenience init(action: @escaping Action) {
            self.init(initialValue: (email: "", password: ""), action: action)
        }
    }
 
    class CreateAccountViewModel: FormViewModel<(name: String, email: String, password: String)> {
        convenience init(action: @escaping Action) {
            self.init(initialValue: (name: "", email: "", password: ""), action: action)
        }
    }
}
