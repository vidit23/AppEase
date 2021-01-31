//
//  FindAMatchView.swift
//  Testing WatchKit Extension
//
//  Created by Vidit Bhargava on 11/19/20.
//

import SwiftUI

struct FindAMatchView: View {
    @State private var score = 0
    @ObservedObject var emojiGuessing = FindAMatch()
    var fileHandler = FileIOManager(directory: URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true), fileName: "0CA88BB4-995C-4BCD-AB26-5AE5925CEDA2-359-0000001D623B8BE")

    var body: some View {
        NavigationView{
            VStack{
                Text(emojiGuessing.gameOptions[emojiGuessing.correctAnswer].uppercased())
                
                Text("Your Score is \(score)").fixedSize()
                
                List{
                ForEach(emojiGuessing.gameOptions, id: \.self) { option in
                    Button(
                        action:{
                            self.animalTapped(option)
                        }, label: {
                            HStack{
                                Spacer()
                                Text(emojiGuessing.emojiNameDict[option]!)
                                Spacer()
                            }
                            
                        })
                }
                    
                }
                
            }
            .navigationBarBackButtonHidden(false)
        }
        .onAppear(perform: {
            let dateFormat = ISO8601DateFormatter()
            var data: Dictionary<String, String> = [
                "timeStamp": dateFormat.string(from: Date()),
                "userToken": UserDefaults.standard.string(forKey: "USERTOKEN") ?? "",
                "gameStatus": "Activated",
                "gameName": "FindAMatch",
            ]
            self.fileHandler.writeToFile(dataToWrite: &data)
        })
        .onDisappear(perform: {
            let dateFormat = ISO8601DateFormatter()
            var data: Dictionary<String, String> = [
                "timeStamp": dateFormat.string(from: Date()),
                "userToken": UserDefaults.standard.string(forKey: "USERTOKEN") ?? "",
                "gameStatus": "Deactivated",
                "gameName": "FindAMatch",
            ]
            self.fileHandler.writeToFile(dataToWrite: &data)
        })
    }
    
    func animalTapped(_ tag:String){
        if tag == emojiGuessing.gameOptions[emojiGuessing.correctAnswer] {
            score += 1
        } else{
            score -= 1
        }
        emojiGuessing.generateNewQuestion()
    }
}

struct FindAMatchView_Previews: PreviewProvider {
    static var previews: some View {
        FindAMatchView()
    }
}
