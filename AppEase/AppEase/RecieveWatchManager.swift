//
//  RecieveWatchManager.swift
//  Testing
//
//  Created by Vidit Bhargava on 11/24/20.
//

import Foundation
import WatchConnectivity

class RecieveManager: WatchSessionManager, ObservableObject {
    
    @Published var textRecieved = ""
    
    override init() {
        super.init()
    }
    
    override func session(_ session: WCSession, didFinish fileTransfer: WCSessionFileTransfer, error: Error?) {
        // handle filed transfer completion
    }

    // Receiver
    override func session(_ session: WCSession, didReceive file: WCSessionFile) {
        // handle receiving file
        DispatchQueue.main.async {
            // make sure to put on the main queue to update UI!
        }
    }
    
    // Receiver
    override func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        // handle receiving message
        DispatchQueue.main.async {
            // make sure to put on the main queue to update UI!
            let data = message["data"]!
            self.textRecieved = data as? String ?? "some error"
        }
    }
}
