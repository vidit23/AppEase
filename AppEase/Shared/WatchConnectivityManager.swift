//
//  WatchConnectivityManager.swift
//  Testing
//
//  Created by Vidit Bhargava on 11/24/20.
//

import Foundation
import SwiftUI
import WatchConnectivity

class WatchConnectivityManager: NSObject, WCSessionDelegate {
    
    static let sharedManager = WatchConnectivityManager()
    
    override init() {
        super.init()
    }

    private let session: WCSession? = WCSession.isSupported() ? WCSession.default : nil

    @available(iOS 9.3, *)
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }

    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
    }

    func sessionDidDeactivate(_ session: WCSession) {
    }
    #endif

    var validSession: WCSession? {

        // paired - the user has to have their device paired to the watch
        // watchAppInstalled - the user must have your watch app installed
        // Note: if the device is paired, but your watch app is not installed
        // consider prompting the user to install it for a better experience
        #if os(iOS)
            if let session = session, session.isPaired && session.isWatchAppInstalled {
                return session
            }
        #elseif os(watchOS)
            return session
        #endif
        return nil
    }
    
    func isReachable() -> Bool {
        if session?.isReachable == nil {
            return false
        } else {
            return session!.isReachable
        }
    }

    func startSession() {
        session?.delegate = self
        session?.activate()
    }
}

// MARK: Application Context
// use when your app needs only the latest information
// if the data was not sent, it will be replaced
extension WatchConnectivityManager {

    // Sender
    func updateApplicationContext(applicationContext: [String : Any]) throws {
        if let session = validSession {
            do {
                try session.updateApplicationContext(applicationContext)
            } catch let error {
                throw error
            }
        }
    }

    // Receiver
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        // handle receiving application context
        DispatchQueue.main.async {
            print("Processing the message on the main thread")
            
            // To handle recieving message on watch about user log in
            let isUserLoggedIn = applicationContext["isLoggedIn"] != nil
            let userToken = applicationContext["userToken"] != nil
            
            if isUserLoggedIn && userToken {
                UserDefaults.standard.set(applicationContext["isLoggedIn"], forKey: "ISUSERLOGGEDIN")
                UserDefaults.standard.set(applicationContext["userToken"], forKey: "USERTOKEN")
            }
        }
    }
}

// MARK: User Info
// use when your app needs all the data
// FIFO queue
extension WatchConnectivityManager {

    // Sender
    func transferUserInfo(userInfo: [String : Any]) -> WCSessionUserInfoTransfer? {
        return validSession?.transferUserInfo(userInfo)
    }

    func session(_ session: WCSession, didFinish userInfoTransfer: WCSessionUserInfoTransfer, error: Error?) {
        // implement this on the sender if you need to confirm that
        // the user info did in fact transfer
    }

    // Receiver
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        // handle receiving user info
        DispatchQueue.main.async {
            // make sure to put on the main queue to update UI!
        }
    }

}

// MARK: Transfer File
extension WatchConnectivityManager {

    // Sender
    func transferFile(file: URL, metadata: [String : Any]) -> WCSessionFileTransfer? {
        return validSession?.transferFile(file, metadata: metadata)
    }

    func session(_ session: WCSession, didFinish fileTransfer: WCSessionFileTransfer, error: Error?) {
        // handle filed transfer completion
        print("Sent file from watch \(fileTransfer.file.fileURL)")
        print("clearning data from file - watch")
        FileIOManager.deleteFile(at: fileTransfer.file.fileURL)
        print("cleared")
    }

    // Receiver
    func session(_ session: WCSession, didReceive file: WCSessionFile) {
        // handle receiving file
        
//        DispatchQueue.main.async {
            var folderPath = FileIOManager.createFolder(folderName: "HealthData")
            let uniqueFileName = UUID().uuidString
            do {
                folderPath.appendPathComponent(uniqueFileName)
                print("Destination URL \(String(describing: folderPath)) \n")
                try FileIOManager.moveFile(from: file.fileURL, to: folderPath)
                print("Transferred the file")
            } catch {
                print("Error__: \(error.localizedDescription)")
            }
//        }
    }

}


// MARK: Interactive Messaging
extension WatchConnectivityManager {

    // Live messaging! App has to be reachable
    private var validReachableSession: WCSession? {
        if let session = validSession , session.isReachable {
            return session
        }
        return nil
    }

    // Sender
    func sendMessage(message: [String : Any],
                     replyHandler: (([String : Any]) -> Void)? = nil,
                     errorHandler: ((Error) -> Void)? = nil)
    {
        print("Sending message \(message)")
        validReachableSession?.sendMessage(message, replyHandler: {_ in }, errorHandler: errorHandler)
    }

    func sendMessageData(data: Data,
                         replyHandler: ((Data) -> Void)? = nil,
                         errorHandler: ((Error) -> Void)? = nil)
    {
        validReachableSession?.sendMessageData(data, replyHandler: replyHandler, errorHandler: errorHandler)
    }
    
    // Receiver
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        // handle receiving message
        
        print("Recieved \(message)")
        let replyData = "Image recieved"
        replyHandler(["Hi": replyData])
        
        DispatchQueue.main.async {
            print("Processing the message on the main thread")
            
            // To handle recieving message on watch about user log in
            let isUserLoggedIn = message["isLoggedIn"] != nil
            let userToken = message["userToken"] != nil
            
            if isUserLoggedIn && userToken {
                UserDefaults.standard.set(message["isLoggedIn"], forKey: "ISUSERLOGGEDIN")
                UserDefaults.standard.set(message["userToken"], forKey: "USERTOKEN")
            }
        }
    }
}
