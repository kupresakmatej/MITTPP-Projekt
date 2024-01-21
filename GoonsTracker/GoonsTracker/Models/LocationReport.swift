//
//  LocationReport.swift
//  GoonsTracker
//
//  Created by Matej Kuprešak on 09.12.2023..
//

import Foundation

struct LocationReport: Codable, Identifiable {
    let id: Int?
    let currentMap: [String]
    let location: [String]
    let time: [String]
    let timeSubmitted: [String]
    let report: [String]

    enum CodingKeys: String, CodingKey {
        case id
        case currentMap = "Current Map"
        case location = "Location"
        case time = "Time"
        case timeSubmitted = "TimeSubmitted"
        case report = "Report"
    }
}
