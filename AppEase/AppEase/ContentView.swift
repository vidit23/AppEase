//
//  ContentView.swift
//  Testing WatchKit Extension
//
//  Created by Vidit Bhargava on 11/16/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var loginManager = LoginManager()
    
    var body: some View {
        ZStack {
            if !UserDefaults.standard.bool(forKey: "ISUSERLOGGEDIN") {
                LoginView(loginManager: loginManager)
            } else {
                DetailView(loginManager: loginManager)
            }
        }
    }
}

extension Color {
    static var themeTextField: Color {
        return Color(red: 220.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, opacity: 1.0)
    }
}

struct DetailView: View {
    @ObservedObject var loginManager: LoginManager
    
    var kafkaManager = KafkaManager()
    
    var body: some View {
        VStack{
            Text("You are logged in")
            
            Button(action: {
                let tDocumentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
                let _ = FileIOManager.findAllFilesInFolder(in: tDocumentDirectory!.appendingPathComponent("HealthData"))
            }, label: {
                Text("List files")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(15.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
            }).padding()
            
            Button(action: {
                kafkaManager.sendFilesInDirectory()
            }, label: {
                Text("Send files")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.green)
                    .cornerRadius(15.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
            }).padding()
            
            Button(action: {
                loginManager.logout()
            }, label: {
                Text("Log out")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.red)
                    .cornerRadius(15.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
            }).padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
