//
//  ReportCardView.swift
//  GoonsTracker
//
//  Created by Matej Kuprešak on 13.01.2024..
//

import SwiftUI

struct ReportCardView: View {
    var report: LocationReport
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
                    Text(report.currentMap[0])
                        .padding(.trailing, 25)
                    
                    Text(report.location[0])
                }
                .bold()
                .padding(.bottom, 15)
                
                Text("Time: \(report.timeSubmitted[0])")
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

#Preview {
    ReportCardView(report: LocationReport(id: 1, currentMap: ["Woods"], location: ["Scav Bunker"], time: ["10-16"], timeSubmitted: [""], report: ["1"]), title: "Tarkovpal last report")
}
