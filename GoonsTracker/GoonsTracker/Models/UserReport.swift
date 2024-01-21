//
//  UserReport.swift
//  GoonsTracker
//
//  Created by Matej Kuprešak on 21.01.2024..
//

import Foundation

struct UserReport: Codable, Identifiable {
    let id: UUID?
    let currentMap: String
    let location: String
    let time: String
    let timeSubmitted: String
    let report: String
    let userName: String
}
