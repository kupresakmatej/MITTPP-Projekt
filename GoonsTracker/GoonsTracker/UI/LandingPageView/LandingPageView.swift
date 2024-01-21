//
//  LandingPageView.swift
//  GoonsTracker
//
//  Created by Matej Kuprešak on 05.01.2024..
//

import SwiftUI

struct LandingPageView: View {
    @StateObject var authViewModel = AuthentificationViewModel()
    
    @Binding var isLoggedIn: Bool
    
    @State var showingFailedAuthAlert = false
    
    var body: some View {
        NavigationView {
            ZStack() {
                Color.black
                    .ignoresSafeArea()
                
                VStack {
                    Text("Goons tracker")
                        .foregroundStyle(.white)
                        .font(.custom("RubikGlitch-Regular", size: 46))
                    
                    VStack {
                        InputBar(placeholder: "Email...", inputType: InputType.regular, input: $authViewModel.emailText)
                            .padding(.top, 50)
                        
                        InputBar(placeholder: "Password...", inputType: InputType.password, input: $authViewModel.passwordText)
                            .frame(width: 300)
                        
                        HStack {
                            Button {
                                do {
                                    try authViewModel.loginUser { result in
                                        switch result {
                                        case .success:                                           
                                            isLoggedIn = true
                                            
                                            print("User logged in successfully")
                                        case .failure(let error):
                                            showingFailedAuthAlert = true
                                            print("Authentication error: \(error.localizedDescription)")
                                        }
                                    }
                                } catch {
                                    print("An error occurred: \(error.localizedDescription)")
                                }
                            } label: {
                                RoundedButton(width: 200, height: 48, buttonText: "Login", buttonColor: Color.gray)
                            }
                            .padding(.top, 10)
                            .alert("Login failed. Check your email and password.", isPresented: $showingFailedAuthAlert) {
                                Button("Try again", role: .cancel) { }
                            }
                        }
                        
                        HStack {
                            Text("Not registered yet?")
                                .foregroundStyle(.gray)
                                .padding(.trailing, 0)
                            
                            NavigationLink(destination: RegisterView(authViewModel: authViewModel)) {
                                Text("Sign up")
                            }
                        }
                        .font(.subheadline)
                    }
                    
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    
                    Image("knightGoon")
                        .resizable()
                        .frame(width: 450, height: 450, alignment: .bottom)
                }
                .ignoresSafeArea()
            }
        }
    }
}
