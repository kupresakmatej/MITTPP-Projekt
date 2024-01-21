//
//  HomeViewModel.swift
//  GoonsTracker
//
//  Created by Matej Kuprešak on 09.12.2023..
//

import Foundation
import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabaseInternal

final class HomeViewModel: ObservableObject {
    @ObservedObject var networkingService = NetworkingService()
    
    @Published var tarkovpalReports = [LocationReport]()
    @Published var firebaseReports = [UserReport]()
    
    @Published var isReportShowing = false
    
    var dbRef = Database.database().reference()
    
    init() {
        fetchFirebaseReports()
    }
}

extension HomeViewModel {
    func fetchReport() {
        networkingService.fetchDefaultResponse() { [weak self] result in
            switch result {
            case .success(let response):
                print("SUCCESS")
                DispatchQueue.main.async {
                    self?.tarkovpalReports.append(response)
                }
            case .failure(let error):
                print("ERROR: \(error)")
            }
            
        }
    }
    
    func reportLocation(userReport: UserReport) {
        let reportRef = dbRef.child("userReports").childByAutoId()
        let reportData = [
            "currentMap": userReport.currentMap,
            "location": userReport.location,
            "time": userReport.time,
            "timeSubmitted": userReport.timeSubmitted,
            "report": userReport.report,
            "userName": userReport.userName
        ]
            
        reportRef.setValue(reportData) { error, _ in
            if let error = error {
                print("Error saving report to Firebase: \(error)")
            } else {
                print("Report saved to Firebase successfully.")
            }
        }
    }
    
    func getCurrentTimeAsString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        
        let currentTime = Date()
        let currentTimeString = dateFormatter.string(from: currentTime)
        
        return currentTimeString
    }
    
    func fetchFirebaseReports() {
        dbRef.child("userReports").observe(.value) { [weak self] snapshot in
            guard let self = self else { return }
            
            if let reportsDictionary = snapshot.value as? [String: Any] {
                let reportsArray = reportsDictionary.compactMap { (key, value) -> UserReport? in
                    if let reportData = value as? [String: Any],
                       let currentMap = reportData["currentMap"] as? String,
                       let location = reportData["location"] as? String,
                       let time = reportData["time"] as? String,
                       let timeSubmitted = reportData["timeSubmitted"] as? String,
                       let report = reportData["report"] as? String,
                       let userName = reportData["userName"] as? String {
                        
                        return UserReport(id: nil, currentMap: currentMap, location: location, time: time, timeSubmitted: timeSubmitted, report: report, userName: userName)
                    }
                    return nil
                }
                
                DispatchQueue.main.async {
                    self.firebaseReports = reportsArray
                }
            }
        }
    }
}
