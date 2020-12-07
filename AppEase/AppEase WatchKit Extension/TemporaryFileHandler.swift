//
//  TemporaryFileHandler.swift
//  Testing WatchKit Extension
//
//  Created by Vidit Bhargava on 11/24/20.
//

import Foundation

extension String {
    func appendLineToURL(fileURL: URL) throws {
         try (self + "\n").appendToURL(fileURL: fileURL)
     }

     func appendToURL(fileURL: URL) throws {
         let data = self.data(using: String.Encoding.utf8)!
         try data.append(fileURL: fileURL)
     }
 }

 extension Data {
     func append(fileURL: URL) throws {
         if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
             defer {
                 fileHandle.closeFile()
             }
             fileHandle.seekToEndOfFile()
             fileHandle.write(self)
         }
         else {
             try write(to: fileURL, options: .atomic)
         }
     }
 }


class TemporaryFileHandler {
    
    var fullURL: URL
    
    init(directory: URL, fileName: String) {
        self.fullURL = directory.appendingPathComponent(fileName)
    }
    
    
    func collectData() {
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "HH:mm:ss E, d MMM y"
        var tempDict: Dictionary<String, String> = ["UserId": "ABCD", "TimeStamp": formatter3.string(from: Date()), "heartRate": String((Int.random(in: 0..<10)))]
        var writeObject: [Dictionary<String, String>] = []
        for _ in 1...10 {
            tempDict["heartRate"] = String((Int.random(in: 0..<10)))
            writeObject.append(tempDict)
        }
        if let theJSONData = try?  JSONSerialization.data(withJSONObject: writeObject),
          let theJSONText = String(data: theJSONData, encoding: String.Encoding.utf8) {
            do {
                print(theJSONText)
                try theJSONText.appendLineToURL(fileURL: self.fullURL)
            } catch {
                // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
            }
        }
    }
    
    func writeToFile(dataToWrite: inout Dictionary<String, String>) {
        if let theJSONData = try?  JSONSerialization.data(withJSONObject: dataToWrite),
          let theJSONText = String(data: theJSONData, encoding: String.Encoding.utf8) {
            do {
                print(theJSONText)
                try theJSONText.appendLineToURL(fileURL: self.fullURL)
            } catch {
                print("Could not write to file \(error.localizedDescription)")
                // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
            }
        }
    }
    
    
    func readData() -> [String] {
        if let startWords = try? String(contentsOf: self.fullURL) {
            let allWords = startWords.components(separatedBy: "\n")
            return allWords
        }
        return [""]
    }
    
    
//    func clearData(){
//        //deleting file
////        let fileManager = FileManager()
////        do{
////            try fileManager.removeItem(at: fullURL)
////        }
////        catch{
////            print("Error deleting file:\(error)")
////        }
////        deleting contents
//        do {
//            try "".write(to: fullURL, atomically: true, encoding: .utf8)
//        } catch let error {
//            print(error)
//        }
//    }
}
