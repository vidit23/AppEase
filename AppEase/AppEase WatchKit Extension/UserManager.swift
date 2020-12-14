//
//  UserManager.swift
//  AppEase WatchKit Extension
//
//  Created by Vidit Bhargava on 12/5/20.
//

import Foundation

class UserManager: ObservableObject {
    static var sharedManager = UserManager()
    
    @Published var hasUserLoggedIn = false
    
}
