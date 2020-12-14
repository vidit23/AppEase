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

class FileInfo {

    let fileName = NSUUID().uuidString
    var fullURL = URL(string: "")
    
    init() {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let directory = documentDirectory
        self.fullURL = NSURL.fileURL(withPathComponents: [directory, fileName])
    }
    
    init(fileURL: URL) {
        self.fullURL = fileURL
    }
    
    
    func collectData(){
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
                try theJSONText.appendLineToURL(fileURL: self.fullURL!)
            } catch {
                // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
            }
        }
        
//        ////Testing Kafka here -----------------
//        let kafkaManger = KafkaManager()
        //add to directory
//        let temporaryFileManager = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//        let fileManager = FileManager()
//        let uniqueFileName = UUID().uuidString
//        do {
//            var transferFileToPath = URL(fileURLWithPath: temporaryFileManager)
//            transferFileToPath.appendPathComponent("/vidit".appending(uniqueFileName))
//            print("Moving file from \(self.fullURL)")
//            print("Destination URL \(transferFileToPath) \n\n\n\n")
//            try fileManager.moveItem(at: self.fullURL!, to: transferFileToPath)
//            print("Transferred the file")
//            kafkaManger.readFilesFromDirectory()
//        } catch {
//            print(error)
//        }
        
        
//        kafkaManger.sendFile(fileURL: self.fullURL!)
//        print("sent!")
        
    }
    
    
    
    func readData() -> [String] {
        do {
            let startWords = try String(contentsOf: self.fullURL!)
            let allWords = startWords.components(separatedBy: "\n")
            return allWords
        } catch {
            print("Error in reading file \(error.localizedDescription)")
            return [""]
        }
        
    }
    
}
