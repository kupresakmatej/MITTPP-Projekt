//
//  HomeView.swift
//  GoonsTracker
//
//  Created by Matej Kuprešak on 09.12.2023..
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    @State var goons = "No goons"
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                Text("Goons")
                    .foregroundStyle(.white)
                    .font(.custom("RubikGlitch-Regular", size: 56))
                    .padding(.bottom, 25)
                
                VStack(spacing: 10) {
                    ForEach(viewModel.tarkovpalReports) { report in
                        ReportCardView(report: report, title: "Tarkovpal last report")
                            .padding(.bottom, 50)
                    }
                }
                
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(.gray)
                        .opacity(0.15)
                        .ignoresSafeArea()
                    
                    VStack {
                        Spacer()
                        
                        Image("Birdeye")
                            .resizable()
                            .frame(width: 350, height: 450, alignment: .bottom)
                            .opacity(0.1)
                            .padding(.leading, 20)
                    }
                    .ignoresSafeArea()
                    
                    VStack {
                        ZStack {
                            Text("Recent reports")
                                .foregroundStyle(.white)
                                .font(.title2)
                                .padding()
                            
                            HStack {
                                Spacer()
                                
                                Button {
                                    viewModel.isReportShowing = true
                                } label: {
                                    RoundedButton(width: 75, height: 25, buttonText: "Report", buttonColor: Color.gray)
                                }
                                .padding(15)
                            }
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            if(viewModel.firebaseReports.isEmpty) {
                                Text("No reports")
                            }
                            
                            HStack {
                                ForEach(viewModel.firebaseReports) { report in
                                    UserReportCardView(report: report, title: "Last report")
                                }
                            }
                        }
                        
                        Spacer()
                    }
                }
            }
            .onAppear {
                viewModel.fetchReport()
            }
            .sheet(isPresented: $viewModel.isReportShowing) {
                ReportSheetView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
