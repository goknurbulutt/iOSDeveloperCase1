//
//  UserListViewModel.swift
//  iOSDeveloperCase
//
//  Created by Göknur Bulut on 4.03.2025.
//
import Foundation

// This viewmodel is responsible for fetching users from the repository
class UserListViewModel {
    private let userRepository = UserRepository()
    var users: [User] = []
    var didUpdateUsers: (() -> Void)?
    var didFailWithError: ((Error) -> Void)?
    
    // Fetches users from the repository using the UserRepository
    func fetchUsers() {
        userRepository.getUsers { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
                self?.didUpdateUsers?()
            case .failure(let error):
                self?.didFailWithError?(error)
            }
        }
    }
}
