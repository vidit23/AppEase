//
//  LoginView.swift
//  Testing
//
//  Created by Vidit Bhargava on 12/5/20.
//

import SwiftUI

struct LoginView: View {
    @State var pass = ""
    @State var mail = ""
    @ObservedObject var loginManager: LoginManager
    
    @State var isLinkActive = false
    @State private var showIncorrectCredentialsAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("AppEase")
                    .font(.largeTitle).foregroundColor(Color.white)
                    .padding([.top, .bottom], 40)
                    .shadow(radius: 10.0, x: 20, y: 10)
                
                Image("logo")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10.0, x: 20, y: 10)
                    .padding(.bottom, 50)
                
                VStack(alignment: .leading, spacing: 15) {
                    TextField("Email", text: $mail)
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.themeTextField)
                        .cornerRadius(20.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                    
                    SecureField("Password", text: $pass)
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.themeTextField)
                        .cornerRadius(20.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                }.padding([.leading, .trailing], 27.5)
                
                NavigationLink(destination: DetailView(loginManager: loginManager), isActive: $isLinkActive) {
                    Button(action: {
                        self.loginManager.checkDetails(username: self.mail, password: self.pass)
                        
                        print("Authenticated? \(self.loginManager.authenticated)")
                        
                        if self.loginManager.authenticated {
                            self.isLinkActive = true
                            self.showIncorrectCredentialsAlert = false
                        }
                        
                        if !self.loginManager.authenticated {
                            self.isLinkActive = false
                            self.showIncorrectCredentialsAlert = true
                        }
                    }) {
                        Text("Sign In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.green)
                            .cornerRadius(15.0)
                            .shadow(radius: 10.0, x: 20, y: 10)
                    }.padding(.top, 50)
                }
                Spacer()
            }
            .navigationBarHidden(true)
            .background(
                LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all))
        }
//        .alert(isPresented: $showIncorrectCredentialsAlert) {
//            Alert(title: Text("Incorrect Credentials"), message: Text("You have entered the wrong username/password"), dismissButton: .default(Text("Retry")))
//        }
    }
}
