//
//  UserStateManager.swift
//  AppEase
//
//  Created by Vidit Bhargava on 12/6/20.
//

import Foundation

class UserStateManager: ObservableObject {
    @Published var isUserLoggedIn = UserDefaults.standard.bool(forKey: "ISUSERLOGGEDIN")
    
    func userLoggedOut() {
        self.isUserLoggedIn = false
    }
    
    func userLoggedIn() {
        self.isUserLoggedIn = true
    }
}
