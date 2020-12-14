//
//  PedometerManager.swift
//  Testing WatchKit Extension
//
//  Created by Vidit Bhargava on 11/20/20.
//

import Foundation
import CoreMotion
import SwiftUI

class PedometerManager: ObservableObject {
    
    private let pedometer: CMPedometer = CMPedometer()
    
    @Published var steps: Int = 0
    @Published var distance: Double = 0
    
    init() {
    }
    
    var isPedometerAvailable: Bool {
        return CMPedometer.isPedometerEventTrackingAvailable() &&
            CMPedometer.isDistanceAvailable() && CMPedometer.isStepCountingAvailable()
    }

    func getPedometerData(startTime: Date) {
        if isPedometerAvailable {
            
            guard let dataAtTwoMinutesEarlier = Calendar.current.date(byAdding: .minute, value: -2, to: Date()) else {
                return
            }
            
            self.pedometer.queryPedometerData(from: dataAtTwoMinutesEarlier, to: Date()) { (data, error) in
                print("Called pedometer fetching")
                guard let data = data, error == nil else { return }
                self.steps = data.numberOfSteps.intValue
                guard let pedometerDistance = data.distance else { return }
                let distanceInMeters = Measurement(value: pedometerDistance.doubleValue, unit: UnitLength.meters)
                self.distance = distanceInMeters.converted(to: .miles).value
            }
        }
    }
}


