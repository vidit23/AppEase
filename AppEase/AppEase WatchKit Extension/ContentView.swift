//
//  ContentView.swift
//  Testing WatchKit Extension
//
//  Created by Vidit Bhargava on 11/16/20.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userStateManager: UserStateManager
    
    var body: some View {
        ZStack {
            if userStateManager.isUserLoggedIn {
                GameList()
            } else {
                TempView()
            }
        }
    }
}


struct TempView: View {
    @EnvironmentObject var userStateManager: UserStateManager
    var body: some View {
        VStack {
            Text("Welcome! Please sign in using the app on your iPhone").padding()
            Button(action: {
                if UserDefaults.standard.bool(forKey: "ISUSERLOGGEDIN") {
                    userStateManager.userLoggedIn()
                }
            }, label: {
                Text("Signed in on the phone")
            })
        }
    }
}


struct GameList: View {
    //    let tempURL = FileIOManager(directory: URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true), fileName: ProcessInfo().globallyUniqueString)
    //    @State var messageData = ""
    //    @State var reachable = "No"
    
    @ObservedObject var healthStore = HealthStore()
    var musicManager = MusicManager()
    @EnvironmentObject var userStateManager: UserStateManager
    
    var fileMetaData: [String: Any] {
        return ["file":"transferred" as Any]
    }
    
    var body: some View{
        List {
            NavigationLink(destination: FindAMatchView()){
                Text("Find A Match")
                    .navigationBarBackButtonHidden(false)
            }
            
            NavigationLink(
                destination: MemoryGameView(),
                label: {Text("Card Match")}
            )
            
            NavigationLink(
                destination: SensorDataView(healthStore: healthStore),
                label: {Text("Sensor Data")}
            )
            
            Button(action: {
                musicManager.setupAudioPlayer(fileName: "example.mp3")
                musicManager.activateAudioSession()
            }, label: {
                Text("Play Music")
            })
            
            Button(action: {
                musicManager.stopPlayingAudio()
            }, label: {
                Text("Pause Music")
            })
            
            Button(action: {
                UserDefaults.standard.set(false, forKey: "ISUSERLOGGEDIN")
                userStateManager.userLoggedOut()
            }, label: {
                Text("Log out")
            })
            
            //            Text("Reachable: \(reachable)")
            //
            //            Button(action: {
            //                if WatchConnectivityManager.sharedManager.isReachable() {
            //                    self.reachable = "Yes"
            //                } else {
            //                    self.reachable = "No"
            //                }
            //            }, label: {
            //                Text("Update reachability")
            //            })
            //
            //            Button(action: {
            //                _ = WatchConnectivityManager.sharedManager.transferFile(file: tempURL.fullURL, metadata: fileMetaData)
            //            }, label: {
            //                Text("File send to phone")
            //            })
            //
            //            TextField("Please enter message to send", text: $messageData)
            //
            //            Button(action: {
            //                WatchConnectivityManager.sharedManager.sendMessage(message: ["data": messageData], replyHandler: nil) { (error) in
            //                    print("Error \(error.localizedDescription)")
            //                }
            //            }, label: {
            //                Text("Send Data")
            //            })
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
