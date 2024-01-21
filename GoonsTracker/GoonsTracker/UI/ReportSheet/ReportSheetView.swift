//
//  ReportSheetView.swift
//  GoonsTracker
//
//  Created by Matej Kuprešak on 21.01.2024..
//

import SwiftUI
import FirebaseAuth

struct ReportSheetView: View {
    @ObservedObject var viewModel: HomeViewModel
    var maps = ["Woods", "Shoreline", "Lighthouse", "Customs"]
    @State var selectedMap = "Woods"
    
    var timeInGame = ["Night", "Morning", "Afternoon", "Nightfall"]
    @State var selectedTime = "Night"
    
    var locations = ["Goons spawn"]
    @State var selectedLocation = "Goons spawn"
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                Text("Where have you seen them?")
                    .foregroundStyle(.white)
                    .font(.title)
                    .bold()
                    .padding(.bottom, 25)
                
                HStack {
                    Text("Map?")
                        .foregroundStyle(.white)
                        .font(.body)
                    
                    Picker("Map", selection: $selectedMap) {
                        ForEach(maps, id: \.self) {
                            Text($0)
                        }
                    }
                    .buttonStyle(.bordered)
                    .pickerStyle(.menu)
                }
                
                HStack {
                    Text("Time?")
                        .foregroundStyle(.white)
                        .font(.body)
                    
                    Picker("Map", selection: $selectedTime) {
                        ForEach(timeInGame, id: \.self) {
                            Text($0)
                        }
                    }
                    .buttonStyle(.bordered)
                    .pickerStyle(.menu)
                }
                
                HStack {
                    Text("Location?")
                        .foregroundStyle(.white)
                        .font(.body)
                    
                    Picker("Map", selection: $selectedLocation) {
                        ForEach(locations, id: \.self) {
                            Text($0)
                        }
                    }
                    .buttonStyle(.bordered)
                    .pickerStyle(.menu)
                }
                
                Button {
                    let userReport = UserReport(id: UUID(), currentMap: selectedMap, location: selectedLocation, time: selectedTime, timeSubmitted: viewModel.getCurrentTimeAsString(), report: "1", userName: Auth.auth().currentUser?.displayName ?? "Unknown")
                    
                    viewModel.reportLocation(userReport: userReport)
                } label: {
                    RoundedButton(width: 200, height: 50, buttonText: "Report", buttonColor: Color.gray)
                        .padding()
                }
            }
        }
    }
}

#Preview {
    ReportSheetView(viewModel: HomeViewModel())
}
