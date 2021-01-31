//
//  CallManager.swift
//  AppEase WatchKit Extension
//
//  Created by Vidit Bhargava on 12/7/20.
//

import Foundation
import WKExtension

class callManager {
    func startCall() {
        var phone = "1234567890"
        if let telURL = URL(string: "tel:\(phone)") {
            let wkExt = WKExtension.shared()
            wkExt.openSystemURL(telURL)
        }
    }
}
