//
//  AppDelegate.swift
//  GoonsTracker
//
//  Created by Matej Kuprešak on 09.01.2024..
//

import Foundation
import Firebase
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
