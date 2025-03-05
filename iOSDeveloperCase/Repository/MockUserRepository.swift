//
//  MockUserRepository.swift
//  iOSDeveloperCase
//
//  Created by Göknur Bulut on 5.03.2025.
//

// MockUserRepository.swift
@testable import iOSDeveloperCase

// This is a mock implementation of UserRepository for testing purposes.
class MockUserRepository: UserRepository {
    func fetchUsers() async throws -> [User] {
        return [
            User(id: 1, name: "Göknur", email: "goknur@example.com", phone: "123-456-7890", website: "www.goknur.com"),
            User(id: 2, name: "Yunus", email: "yunus@example.com", phone: "987-654-3210", website: "www.yunus.com")
        ]
    }
}
