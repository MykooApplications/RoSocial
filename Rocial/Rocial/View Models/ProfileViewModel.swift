//
//  ProfileViewModel.swift
//  Rocial
//
//  Created by Roshan Mykoo on 9/29/22.
//

import Foundation



@MainActor
class ProfileViewModel: ObservableObject, StateManager {
    @Published var name: String
    @Published var profileImageURL: URL? {
        didSet {
            profileImageURLDidChange(from: oldValue)
        }
    }
    @Published var error: Error?
    @Published var isWorking = false
    private let authService: AuthService
    
    init(user: User, authService: AuthService) {
        print("[ProfileViewModel]  user.profileImageURL = \(user.profileImageURL) ")
        self.name = user.name
        self.profileImageURL = user.profileImageURL
        self.authService = authService
    }
    
    func signOut() {
        withStateManagingTask(perform: authService.signOut)
    }
    
    private func profileImageURLDidChange(from oldValue: URL?) {
        print("[ProfileViewModel]  oldValue = \(oldValue)")
        guard profileImageURL != oldValue else { return }
        withStateManagingTask { [self] in
            try await authService.updateProfileImage(to: profileImageURL)
        }
    }
}
