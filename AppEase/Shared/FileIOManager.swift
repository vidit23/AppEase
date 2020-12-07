//
//  FileIOManager.swift
//  Testing
//
//  Created by Vidit Bhargava on 12/5/20.
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



class FileIOManager {

    static let sharedManager = FileIOManager()

    var fullURL: URL

    init() {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let directory = documentDirectory
        self.fullURL = NSURL.fileURL(withPathComponents: [directory, NSUUID().uuidString])!
    }

    init(fileURL: URL) {
        self.fullURL = fileURL
    }

    init(directory: URL, fileName: String) {
        self.fullURL = directory.appendingPathComponent(fileName)
    }


//    func collectData() {
//        let formatter3 = DateFormatter()
//        formatter3.dateFormat = "HH:mm:ss E, d MMM y"
//        var tempDict: Dictionary<String, String> = ["UserId": "ABCD", "TimeStamp": formatter3.string(from: Date()), "heartRate": String((Int.random(in: 0..<10)))]
//        var writeObject: [Dictionary<String, String>] = []
//        for _ in 1...10 {
//            tempDict["heartRate"] = String((Int.random(in: 0..<10)))
//            writeObject.append(tempDict)
//        }
//        if let theJSONData = try?  JSONSerialization.data(withJSONObject: writeObject),
//          let theJSONText = String(data: theJSONData, encoding: String.Encoding.utf8) {
//            do {
//                print(theJSONText)
//                try theJSONText.appendLineToURL(fileURL: self.fullURL)
//            } catch {
//                // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
//            }
//        }
//    }

    func writeToFile(dataToWrite: inout Dictionary<String, String>) {
        
        if let theJSONData = try?  JSONSerialization.data(withJSONObject: dataToWrite),
          let theJSONText = String(data: theJSONData, encoding: String.Encoding.utf8) {
            do {
                print(theJSONText)
                try theJSONText.appendLineToURL(fileURL: self.fullURL)
            } catch {
                // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
                print("Could not write to file \(error.localizedDescription)")
            }
        }
    }


    func readData() -> [String] {
        do {
            let startWords = try String(contentsOf: self.fullURL)
            let allWords = startWords.components(separatedBy: "\n")
            return allWords
        } catch {
            print("Error in reading file \(error.localizedDescription)")
            return [""]
        }
    }
    
    static func createFolder(folderName: String) -> URL {
        let fileManager = FileManager.default
        if let tDocumentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let filePath =  tDocumentDirectory.appendingPathComponent("\(folderName)")
            if !fileManager.fileExists(atPath: filePath.path) {
                do {
                    try fileManager.createDirectory(atPath: filePath.path, withIntermediateDirectories: true, attributes: nil)
                    print("Created folder called \(folderName)")
                } catch {
                    print("Couldn't create document directory")
                }
            } else {
                print("Folder \(folderName) already exists, no need to create")
            }
            return filePath
        }
        return URL(fileURLWithPath: "")
    }
    
    static func moveFile(from: URL, to: URL) throws {
        let fileManager = FileManager.default
        try fileManager.moveItem(at: from, to: to)

    }
    
    static func findAllFilesInFolder(in folderURL: URL) -> [URL] {
        let fileManager = FileManager.default
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil)
            for item in fileURLs {
                print("Found \(item)")
            }
            return fileURLs
        } catch {
            print("Couldnt read the contents of the folder: \(error.localizedDescription)")
            // failed to read directory – bad permissions, perhaps?
        }
        return []
    }
    
    static func deleteFile(at fileURL: URL){
        //deleting file
        let fileManager = FileManager()
        do {
            try fileManager.removeItem(at: fileURL)
        }
        catch{
            print("Error deleting file: \(error)")
        }
    }

}
