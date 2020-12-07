//
//  GenerateMockHeartRateData.swift
//  Testing WatchKit Extension
//
//  Created by Vidit Bhargava on 11/20/20.
//

import Foundation
import HealthKit

extension HealthStore {
    @objc func saveMockHeartData() {
        
        // 1. Create a heart rate BPM Sample
        let heartRateType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
        let heartRateQuantity = HKQuantity(unit: HKUnit(from: "count/min"),
                                           doubleValue: Double(arc4random_uniform(80) + 100))
        let heartSample = HKQuantitySample(type: heartRateType,
                                           quantity: heartRateQuantity, start: Date(), end: Date())
        
        // 2. Save the sample in the store
        print("Generated mock data")
        self.healthKitStore.save(heartSample, withCompletion: { (success, error) -> Void in
            if let error = error {
                print("Error saving heart sample: \(error.localizedDescription)")
            }
        })
    }
    
    func startMockHeartData() {
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(saveMockHeartData),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    func stopMockHeartData() {
        self.timer?.invalidate()
    }
}
