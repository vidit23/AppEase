//
//  KafkaManager.swift
//  Testing
//
//  Created by Vidit Bhargava on 11/24/20.
//

import Foundation
import Franz

class KafkaManager {
    
    let cluster: Cluster
    var timer: Timer?
    
    var healthDataFileDirectory = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]).appendingPathComponent("HealthData")

    
    init() {
        cluster = Cluster(brokers: [("192.168.0.155", 9092)], clientId: "AppEase")
        timerInvoke()
    }
    
    func sendMessage(message: String) {
        cluster.sendMessage("healthData", message: message)
    }
    
    func sendFile(fileURL: URL) {
        let fileContent = FileIOManager(fileURL: fileURL).readData()
        for line in fileContent {
            print("Sending \(line)")
            cluster.sendMessage("healthData", message: line)
        }
    }
    
    func timerInvoke() {
        timer = Timer.scheduledTimer(timeInterval: 1800,
                                     target: self,
                                     selector: #selector(sendFilesInDirectory),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    //read files form a directory and send to kafka manager
    @objc func sendFilesInDirectory() {
        print("Sending files from health directory to Kafka")
        let fileURLs = FileIOManager.findAllFilesInFolder(in: healthDataFileDirectory)
        for item in fileURLs {
            sendFile(fileURL: item)
            print("Sent the file and now deleting the file")
            FileIOManager.deleteFile(at: item)
        }
    }
    
}
