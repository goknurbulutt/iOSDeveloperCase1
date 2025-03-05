//
//  iOSDeveloperCaseTests.swift
//  iOSDeveloperCaseTests
//
//  Created by Göknur Bulut on 4.03.2025.
//

//  iOSDeveloperCaseTests.swift
//  iOSDeveloperCaseTests
//
//  Created by Göknur Bulut on 4.03.2025.
//

import XCTest
@testable import iOSDeveloperCase

final class iOSDeveloperCaseTests: XCTestCase {

    var userRepository: MockUserRepository!

    override func setUpWithError() throws {
        userRepository = MockUserRepository()
    }

    override func tearDownWithError() throws {
        userRepository = nil
    }

    func testFetchUsers() async throws {
        // Act
        let users = try await userRepository.fetchUsers()

        // Assert
        XCTAssertEqual(users.count, 2, "Kullanıcı sayısı 2 olmalı")
        XCTAssertEqual(users.first?.name, "Göknur", "İlk kullanıcının ismi Göknur olmalı")
    }
}
