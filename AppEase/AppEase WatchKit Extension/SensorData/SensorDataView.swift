//
//  SensorDataView.swift
//  Testing WatchKit Extension
//
//  Created by Vidit Bhargava on 11/20/20.
//
//  self.healthStore.startHeartRateQuery(quantityTypeIdentifier: .heartRate)


import SwiftUI

struct SensorDataView: View {
    
    @ObservedObject var healthStore: HealthStore
    
    var body: some View {
        List {
            
//            Button(action: {
//                HealthStore.requestAuthorization()
//            }, label: {
//                Text("Authorize")
//            })
            
            NavigationLink(
                destination: DisplayReadings(healthStore: healthStore),
                label: {
                    Text("See Readings")
                })
            
            Button(action: {
                print("Start Mock HR Data")
                self.healthStore.startMockHeartData()
            }, label: {
                Text("Start Mock HR Data")
            })
            
            Button(action: {
                print("Stop HR Data")
                self.healthStore.stopMockHeartData()
            }, label: {
                Text("Stop HR Data")
            })
            
            
            
        }
    }
}

struct DisplayReadings: View {
    
    @ObservedObject var healthStore: HealthStore
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading) {
                List {
                    Text("Heart rate \(healthStore.heartRate)")
                    
                    Text("Steps:  \(healthStore.steps)")
                    
                    Text("Walking: \(healthStore.stationaryLabel)")
                    
                    Text("Blood type \(healthStore.bloodType)")
                    
                    Text("Date of birth \(healthStore.age)")
                    
                    Text("Sex \(healthStore.sex)")
                    
//                    Text(self.healthStore.pedometerManager.steps != nil ? "Steps: \(self.healthStore.pedometerManager.steps!)" : "Steps: Not Recorded").padding()
//
//                    Text(self.healthStore.pedometerManager.distance != nil ? String(format: "Distance: %.2f miles",self.healthStore.pedometerManager.distance!) : "Distance: Not Recorded").padding()
                }
            }
        }
    }
}

