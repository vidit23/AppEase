//
//  File.swift
//  Testing WatchKit Extension
//
//  Created by Vidit Bhargava on 11/24/20.
//

import Foundation


func test(data: String) {
//    WatchSessionManager.sharedManager.startSession()
    WatchSessionManager.sharedManager.sendMessage(message: ["data" : 5])
}
