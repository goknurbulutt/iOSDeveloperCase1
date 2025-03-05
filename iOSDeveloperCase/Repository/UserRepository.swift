//
//  UserRepository.swift
//  iOSDeveloperCase
//
//  Created by Göknur Bulut on 4.03.2025.
//

import Foundation

// This class is responsible for fetching users from the network.
class UserRepository {
    private let networkService = NetworkService.shared
    
    // Fetches users from the network using the NetworkService
    func getUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        networkService.fetchUsers(completion: completion)
    }
}
