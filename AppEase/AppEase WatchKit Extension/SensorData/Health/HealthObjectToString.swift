//
//  HealthObjectToString.swift
//  Testing WatchKit Extension
//
//  Created by Vidit Bhargava on 11/20/20.
//

import Foundation
import HealthKit

extension HKBloodTypeObject {
    func string()->String {
        switch self.bloodType {
        case .abNegative:
            return "AB-"
        case .abPositive:
            return "AB+"
        case .aNegative:
            return "A-"
        case .aPositive:
            return "A+"
        case .bNegative:
            return "B-"
        case .bPositive:
            return "B+"
        case .oNegative:
            return "O-"
        case .oPositive:
            return "O+"
        default:
            return "Not Set"
        }
    }
}

extension HKBiologicalSexObject {
    func string()->String {
        switch self.biologicalSex.rawValue {
        case 1:
            return "Female"
        case 2:
            return "Male"
        case 3:
            return "Other"
        default:
            return "Not Set"
        }
    }
}
