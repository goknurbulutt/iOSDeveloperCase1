//
//  User.swift
//  iOSDeveloperCase
//
//  Created by Göknur Bulut on 4.03.2025.
//

import Foundation

//This is response model for user data
struct User: Codable {
    let id: Int?
    let name: String?
    let email: String?
    let phone: String?
    let website: String?
}
