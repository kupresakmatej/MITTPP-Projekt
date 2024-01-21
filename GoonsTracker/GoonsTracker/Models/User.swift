//
//  User.swift
//  GoonsTracker
//
//  Created by Matej Kuprešak on 09.01.2024..
//

import Foundation

enum UserType: String, Codable {
    case regular = "Regular"
    case vip = "VIP"
    case respectable = "Respectable"
}

struct User: Codable {
    let id: UUID
    let name: String
    let email: String
    let userType: UserType
}
