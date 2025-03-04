//
//  APIService.swift
//  iOSDeveloperCase
//
//  Created by Göknur Bulut on 4.03.2025.
//

import Foundation


class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    private let baseURL = "https://jsonplaceholder.typicode.com"
    
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        let url = URL(string: "\(baseURL)/users")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                completion(.success(users))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
