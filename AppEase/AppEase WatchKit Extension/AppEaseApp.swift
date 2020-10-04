//
//  AppEaseApp.swift
//  AppEase WatchKit Extension
//
//  Created by Vidit Bhargava on 10/4/20.
//

import SwiftUI

@main
struct AppEaseApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}

struct AppEaseApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
