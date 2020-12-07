//
//  ActivityManager.swift
//  Testing WatchKit Extension
//
//  Created by Vidit Bhargava on 11/27/20.
//

import Foundation
import CoreMotion

class ActivityManager: ObservableObject {
    @Published var stationaryLabel: String
    @Published var walkingLabel: String
    @Published var runningLabel: String
    @Published var automotiveLabel: String
    @Published var cyclingLabel: String
    @Published var confidenceLabel: String
    @Published var unknownLabel: String
    
    let activityManager = CMMotionActivityManager()
    
    init() {
        self.stationaryLabel = "Stationary: No"
        self.walkingLabel = "Walking: No"
        self.runningLabel = "Running: No"
        self.automotiveLabel = "Automotive: No"
        self.cyclingLabel = "Cycling: No"
        self.confidenceLabel = "Confidence: Low"
        self.unknownLabel = "Unknown: No"
//        self.startUpdatingActivity()
    }
    
    func startUpdatingActivity() -> [String]{
        if CMMotionActivityManager.isActivityAvailable() {
            self.activityManager.startActivityUpdates(to: OperationQueue.main) { (motion) in
                print("fetching activity manager setting")
                self.stationaryLabel = (motion?.stationary)! ? "True" : "False"
                self.walkingLabel = (motion?.walking)! ? "True" : "False"
                self.runningLabel = (motion?.running)! ? "True" : "False"
                self.automotiveLabel = (motion?.automotive)! ? "True" : "False"
                self.cyclingLabel = (motion?.cycling)! ? "True" : "False"
                self.unknownLabel = (motion?.unknown)! ? "True" : "False"
                if motion?.confidence == CMMotionActivityConfidence.low {
                    self.confidenceLabel = "Low"
                } else if motion?.confidence == CMMotionActivityConfidence.medium {
                    self.confidenceLabel = "Medium"
                } else if motion?.confidence == CMMotionActivityConfidence.high {
                    self.confidenceLabel = "High"
                }
            }
            return [self.stationaryLabel, self.walkingLabel, self.runningLabel, self.automotiveLabel, self.cyclingLabel, self.unknownLabel, self.confidenceLabel]
        } else {
            print("Activity manager is unavailable")
        }
        return []
//        let json_data: [Any]  = [
//            [
//                "stationary": self.stationaryLabel == "True" ? true : false,
//                "walking": self.walkingLabel == "True" ? true : false,
//                "running": self.runningLabel == "True" ? true : false,
//                "automotive": self.automotiveLabel == "True" ? true : false,
//                "cycling": self.cyclingLabel == "True" ? true : false,
//                "unknown": self.unknownLabel == "True" ? true : false,
//                "confidenceLow": self.confidenceLabel == "Low" ? true : false,
//                "confidenceMed": self.confidenceLabel == "Good" ? true : false,
//                "confidenceHigh": self.confidenceLabel == "High" ? true : false,
//            ]
//        ]
    }

}
