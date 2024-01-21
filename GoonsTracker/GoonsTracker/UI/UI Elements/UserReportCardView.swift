//
//  UserReportCardView.swift
//  GoonsTracker
//
//  Created by Matej Kuprešak on 21.01.2024..
//

import SwiftUI

struct UserReportCardView: View {
    var report: UserReport
    var title: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .frame(width: 300, height: 200)
                .foregroundColor(.gray)
            
            VStack {
                Text(title)
                    .font(.custom("RubikGlitch-Regular", size: 24))
                    .padding(.bottom, 15)
                
                HStack {
                    Text(report.currentMap)
                        .padding(.trailing, 25)
                    
                    Text(report.location)
                }
                .bold()
                .padding(.bottom, 15)
                
                Text("Time: \(report.time)")
                    .bold()
                
                if(!title.contains("Tarkovpal")) {
                    Button() {
                        
                    } label: {
                        RoundedButton(width: 125, height: 25, buttonText: "Details", buttonColor: Color.white)
                    }
                    .padding()
                }
            }
        }
    }
}
