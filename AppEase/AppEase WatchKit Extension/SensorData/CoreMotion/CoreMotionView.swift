//
//  CoreMotionView.swift
//  Testing WatchKit Extension
//
//  Created by Vidit Bhargava on 11/20/20.
//

import SwiftUI

struct CoreMotionView: View {
    @ObservedObject var pedometer = Pedometer()
    
    var body: some View {
        VStack {
            Text(self.pedometer.steps != nil ? "\(self.pedometer.steps!) steps" : "no steps").padding()
            Text(self.pedometer.distance != nil ? String(format: "%.2f miles",self.pedometer.distance!) : "no distance").padding()
                
                .onAppear {
                    self.pedometer.getPedometerData(startTime: Date())
                }
        }
    }
}

struct CoreMotionView_Previews: PreviewProvider {
    static var previews: some View {
        CoreMotionView()
    }
}
