//
//  SensorDataManager.swift
//  AppEase WatchKit Extension
//
//  Created by Vidit Bhargava on 12/5/20.
//

import Foundation
import Combine

class SensorDataManager: ObservableObject {
    
    @Published var heartDataManager = HealthStore()
    var heartDataManagerPropogater: AnyCancellable? = nil
    
    @Published var pedometerManager = PedometerManager()
    var pedometerManagerPropogater: AnyCancellable? = nil
    
    @Published var activityManager = ActivityManager()
    var activityManagerPropogater: AnyCancellable? = nil
    
    var timer: Timer?
    
    init() {
        pedometerManagerPropogater = pedometerManager.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        }
        heartDataManagerPropogater = heartDataManager.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        }
        activityManagerPropogater = activityManager.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        }
//        setupTimerForSendingFile()
    }
    
//    func setupTimerForSendingFile() {
//        timer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(sendFile), userInfo: nil, repeats: true)
//    }
//
//    @objc func sendFile(){
//        _ = WatchConnectivityManager.sharedManager.transferFile(file: fileHandler.fullURL, metadata: fileMetaData)
//    }
    
    
}
