//
//  ConstructHealthView.swift
//  Testing WatchKit Extension
//
//  Created by Vidit Bhargava on 11/16/20.
//
//  https://developer.apple.com/documentation/healthkit/data_types
import SwiftUI
import Foundation
import HealthKit
import CoreMotion
import UserNotifications

class HealthStore: ObservableObject {
    
    var healthKitStore: HKHealthStore = HKHealthStore()
    let heartRateQuantity = HKUnit(from: "count/min")
    var query: HKStatisticsCollectionQuery?
    var timer: Timer?
    var fileMetaData: [String: Any] {
        return ["file":"transferred" as Any]
    }
    
    private let pedometer: CMPedometer = CMPedometer()
    var isPedometerAvailable: Bool {
        return CMPedometer.isPedometerEventTrackingAvailable() && CMPedometer.isDistanceAvailable() && CMPedometer.isStepCountingAvailable()
    }
    
    private let activityManager = CMMotionActivityManager()
    
    var previousHeartRateQueryTime: Date
    
//    var fileHandler = FileIOManager(directory: URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true), fileName: ProcessInfo().globallyUniqueString)
    
    var fileHandler = FileIOManager(directory: URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true), fileName: "0CA88BB4-995C-4BCD-AB26-5AE5925CEDA2-359-0000001D623B8BE")
    
    
    @Published var heartRate = 0
    @Published var age = 0
    @Published var stepCount = 0
    @Published var sex = ""
    @Published var bloodType = ""
    @Published var steps: Int = 0
    @Published var distance: Double = 0
    
    @Published var stationaryLabel: Int = 0
    @Published var walkingLabel: Int = 0
    @Published var runningLabel: Int = 0
    @Published var automotiveLabel: Int = 0
    @Published var cyclingLabel: Int = 0
    @Published var unknownLabel: Int = 0
    
    var longitude = 25.337623
    var latitude = 55.389198
    
    init() {
        previousHeartRateQueryTime = Date()
        getBloodType()
        getAge()
        getBiologicalSex()
        startHeartRateQuery(quantityTypeIdentifier: .heartRate)
//        startObserving()
        timerInvoke()
    }
    
    static func requestAuthorization() {
        // The quantity types to read from the health store.
        let typesToRead : Set<HKObjectType> = [
            HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.biologicalSex)!,
            HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.bloodType)!,
            HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.wheelchairUse)!,
            HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.dateOfBirth)!,
            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
            HKQuantityType.quantityType(forIdentifier: .stepCount)!,
            HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
        ]
        
        // The quantity type to write to the health store.
        let typesToShare: Set<HKSampleType> = [
            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
            HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
        ]
        
        // Request authorization for those quantity types.
        HKHealthStore().requestAuthorization(toShare: typesToShare, read: typesToRead) { (success, error) in }
    }
    
    
    func startHeartRateQuery(quantityTypeIdentifier: HKQuantityTypeIdentifier) {
        //        let devicePredicate = HKQuery.predicateForObjects(from: [HKDevice.local()])
        let updateHandler: (HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void = {
            query, samples, deletedObjects, queryAnchor, error in
            guard let samples = samples as? [HKQuantitySample] else {
                return
            }
            self.process(samples, type: quantityTypeIdentifier)
            self.storeAnchor(anchor: queryAnchor)
//            self.getPedometerData()
//            self.startUpdatingActivity()
            self.previousHeartRateQueryTime = Date()
//            self.checkIfNotificationInstance()
//            self.writeDataToFile(timeStamp: Date())
        }
        
        let prevAnchor = retrieveAnchor()
        let query = HKAnchoredObjectQuery(type: HKObjectType.quantityType(forIdentifier: quantityTypeIdentifier)!, predicate: nil, anchor: prevAnchor, limit: HKObjectQueryNoLimit, resultsHandler: updateHandler)
        query.updateHandler = updateHandler
        self.healthKitStore.execute(query)
    }
    
    func storeAnchor(anchor: HKQueryAnchor?) {
        guard let anchor = anchor else { return }
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: anchor, requiringSecureCoding: true)
            UserDefaults.standard.set(data, forKey: "HkUserDefaultsAnchorKey")
        } catch {
            print("Unable to store new anchor")
        }
    }

    func retrieveAnchor() -> HKQueryAnchor? {
        guard let data = UserDefaults.standard.data(forKey: "HkUserDefaultsAnchorKey") else { return nil }
        do {
            return try NSKeyedUnarchiver.unarchivedObject(ofClass: HKQueryAnchor.self, from: data)
        } catch {
            print("Unable to retrieve an anchor")
            return nil
        }
    }
    
    
    
    func process(_ samples: [HKQuantitySample], type: HKQuantityTypeIdentifier) {
//        var sumHeartRate = 0.0
//        var sampleCount = 0
        print("Registered a new heart rate")
//        for sample in samples {
//            print(sample.startDate)
//            if type == .heartRate {
//                sumHeartRate += sample.quantity.doubleValue(for: heartRateQuantity)
//                sampleCount += 1
//            }
//        }
//        DispatchQueue.main.async {
//            if sampleCount == 0 {
//                sampleCount = 1
//            }
//            self.heartRate = Int(sumHeartRate / Double(sampleCount))
//        }
        DispatchQueue.main.async {
            for sample in samples {
//                print(sample.startDate)
                if type == .heartRate {
                    self.heartRate = Int(sample.quantity.doubleValue(for: self.heartRateQuantity))
                    self.getPedometerData()
                    self.startUpdatingActivity()
                    self.checkIfNotificationInstance()
                    self.writeDataToFile(timeStamp: sample.startDate)
//                    sumHeartRate += sample.quantity.doubleValue(for: heartRateQuantity)
//                    sampleCount += 1
                }
            }
        }
    }
    
    func writeDataToFile(timeStamp: Date) {
        DispatchQueue.main.async {
            let dateFormat = ISO8601DateFormatter()
            var data: Dictionary<String, String> = [
                "timeStamp": dateFormat.string(from: timeStamp),
                "userToken": UserDefaults.standard.string(forKey: "USERTOKEN") ?? "",
                "heartRate": String(self.heartRate),
                "age": String(self.age),
                "sex": self.sex,
                "bloodType": self.bloodType,
                "stepsCount": String(self.steps),
                "distanceCovered": String(self.distance),
                "stationaryLabelCount": String(self.stationaryLabel),
                "walkingLabelCount": String(self.walkingLabel),
                "runningLabelCount": String(self.runningLabel),
                "automotiveLabelCount": String(self.automotiveLabel),
                "cyclingLabelCount": String(self.cyclingLabel),
                "unknownLabelCount": String(self.unknownLabel),
                "longitude": String(self.longitude),
                "latitude": String(self.latitude),
            ]
            self.fileHandler.writeToFile(dataToWrite: &data)
        }
    }
    
    func checkIfNotificationInstance() {
        let content = UNMutableNotificationContent()
        content.title = "Chill"
        content.subtitle = "Hi, your heart rate seems unusually high, play a game"
        content.sound = UNNotificationSound.default

        if self.heartRate > 100 && self.runningLabel == 0 {
            // show this notification  now
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

            // choose a random identifier
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

            // add our notification request
            UNUserNotificationCenter.current().add(request)
        }
    }
    
    func getPedometerData() {
        if isPedometerAvailable {
            
            guard let dataAtTwoMinutesEarlier = Calendar.current.date(byAdding: .minute, value: -1, to: Date()) else {
                return
            }
            pedometer.queryPedometerData(from: dataAtTwoMinutesEarlier, to: Date()) { (data, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                if let data = data {
                    DispatchQueue.main.async {
                        //                        print("Called pedometer fetching")
                        self.steps = data.numberOfSteps.intValue
                        guard let pedometerDistance = data.distance else { return }
                        let distanceInMeters = Measurement(value: pedometerDistance.doubleValue, unit: UnitLength.meters)
                        self.distance = distanceInMeters.converted(to: .miles).value
                    }
                }
            }
        }
    }
    
    func startUpdatingActivity(){
        if CMMotionActivityManager.isActivityAvailable() {
            
            guard let dataAtTwoMinutesEarlier = Calendar.current.date(byAdding: .minute, value: -1, to: Date()) else {
                return
            }
            
            activityManager.queryActivityStarting(from: dataAtTwoMinutesEarlier, to: Date(), to: .main) { (data, error) in
                if let error = error {
                    print("queryActivityStarting Error: \(error.localizedDescription)")
                    return
                }
                var stationary = 0, walking = 0, running = 0, automotive = 0, cycling = 0, unknown = 0
                data?.forEach { activity in
                        if activity.stationary {
                            stationary += 1
                        }
                        if activity.walking {
                            walking += 1
                        }
                        if activity.running {
                            running += 1
                        }
                        if activity.automotive {
                            automotive += 1
                        }
                        if activity.cycling {
                            cycling += 1
                        }
                        if activity.unknown {
                            unknown += 1
                        }
                }
                (self.stationaryLabel, self.walkingLabel, self.runningLabel, self.automotiveLabel, self.cyclingLabel, self.unknownLabel) = (stationary, walking, running, automotive, cycling, unknown)
            }
        } else {
            print("Activity manager is unavailable")
        }
    }
    
    func timerInvoke() {
        timer = Timer.scheduledTimer(timeInterval: 60,
                                     target: self,
                                     selector: #selector(sendFile),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc func sendFile(){
        print("Timer Invoked: Sending file to iOS")
        _ = WatchConnectivityManager.sharedManager.transferFile(file: fileHandler.fullURL, metadata: fileMetaData)
    }
    
    
}
