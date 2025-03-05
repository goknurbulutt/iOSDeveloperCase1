//
//  APIService.swift
//  iOSDeveloperCase
//
//  Created by Göknur Bulut on 4.03.2025.
//

import Foundation

// This is a simple network service that fetches users from a remote server.
class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    private let baseURL = "https://jsonplaceholder.typicode.com"
    
    // Fetches users from the remote server
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/users") else {
            let error = NSError(domain: "NetworkService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                let networkError = NSError(domain: "NetworkService", code: -2, userInfo: [NSLocalizedDescriptionKey: "Network error: \(error.localizedDescription)"])
                completion(.failure(networkError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                let error = NSError(domain: "NetworkService", code: -3, userInfo: [NSLocalizedDescriptionKey: "Server returned an invalid response"])
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "NetworkService", code: -4, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }
            
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                completion(.success(users))
            } catch {
                let parsingError = NSError(domain: "NetworkService", code: -5, userInfo: [NSLocalizedDescriptionKey: "Failed to decode response: \(error.localizedDescription)"])
                completion(.failure(parsingError))
            }
        }
        
        task.resume()
    }
}
