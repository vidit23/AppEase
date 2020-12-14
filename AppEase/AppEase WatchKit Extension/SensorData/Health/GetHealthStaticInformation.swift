//
//  GetHealthStaticInformation.swift
//  Testing WatchKit Extension
//
//  Created by Vidit Bhargava on 11/20/20.
//

import Foundation
import HealthKit

extension HealthStore {
    func getBloodType() {
        var bloodType:HKBloodTypeObject?
        do {
            bloodType = try self.healthKitStore.bloodType()
            self.bloodType = bloodType!.string()
        } catch {}
    }
    
    func getAge() {
        print("Getting age")
        var age:Int?
        
        do {
            let birthday = try self.healthKitStore.dateOfBirthComponents()
            let date = Date()
            let today = Calendar.current
            let nowYear = today.dateComponents([.year], from: date)
            age = nowYear.year! - birthday.year!
        } catch {}
        
        if age != nil {
            self.age = age!
        } else {
            print("No age")
            self.age = 0
        }
    }
    
    func getBiologicalSex() {
        var sex:HKBiologicalSexObject?
        do {
            sex = try self.healthKitStore.biologicalSex()
            self.sex = sex!.string()
        } catch {}
    }
}
