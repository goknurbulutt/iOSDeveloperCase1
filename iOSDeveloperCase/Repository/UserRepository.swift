//
//  UserRepository.swift
//  iOSDeveloperCase
//
//  Created by Göknur Bulut on 4.03.2025.
//

import Foundation


class UserRepository {
    private let networkService = NetworkService.shared
    
    func getUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        networkService.fetchUsers(completion: completion)
    }
}
