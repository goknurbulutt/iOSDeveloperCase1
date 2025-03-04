//
//  UserDetailViewModel.swift
//  iOSDeveloperCase
//
//  Created by Göknur Bulut on 4.03.2025.
//


import Foundation

class UserDetailViewModel {
    
    private let user: User
    
    
    init(user: User) {
        self.user = user
    }
    
    
    func fetchUserDetails(completion: @escaping (Result<User, Error>) -> Void) {
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            completion(.success(self.user))  // Returning the user
        }
    }
}
