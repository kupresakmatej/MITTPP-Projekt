//
//  ContentView.swift
//  GoonsTracker
//
//  Created by Matej Kuprešak on 09.12.2023..
//

import SwiftUI

struct ContentView: View {
    @StateObject var homeViewModel = HomeViewModel()
    @State var isLoggedIn = false
    
    var body: some View {
        if isLoggedIn {
            HomeView(viewModel: homeViewModel)
        } else {
            LandingPageView(isLoggedIn: $isLoggedIn)
        }
    }
}

#Preview {
    ContentView()
}
