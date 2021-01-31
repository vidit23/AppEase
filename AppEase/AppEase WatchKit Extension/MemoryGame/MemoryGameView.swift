//
//  MemoryGameView.swift
//  Testing WatchKit Extension
//
//  Created by Vidit Bhargava on 11/19/20.
//

import SwiftUI

struct MemoryGameView: View {
    @ObservedObject var viewModel = EmojiMemoryGame()
    
    var fileHandler = FileIOManager(directory: URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true), fileName: "0CA88BB4-995C-4BCD-AB26-5AE5925CEDA2-359-0000001D623B8BE")
    
    var body: some View {
        NavigationView{
            if viewModel.newGameStart == false {
                Grid(viewModel.cards) { card in
                    CardView(card: card).onTapGesture {
                        withAnimation(.easeInOut(duration: 0.75)) {
                            self.viewModel.choose(card: card)
                        }
                    }
                }
                .foregroundColor(Color.orange)
            } else {
                VStack {
                    Text("Congratulations")
                    Button(action: {
                        withAnimation(.easeInOut(duration: 2)) {
                            self.viewModel.resetGame()
                        }
                    }, label: {
                        Text("New Game")
                    })
                }
            }
        }
        .onAppear(perform: {
            let dateFormat = ISO8601DateFormatter()
            var data: Dictionary<String, String> = [
                "timeStamp": dateFormat.string(from: Date()),
                "userToken": UserDefaults.standard.string(forKey: "USERTOKEN") ?? "",
                "gameStatus": "Activated",
                "gameName": "MemoryGame",
            ]
            self.fileHandler.writeToFile(dataToWrite: &data)
        })
        .onDisappear(perform: {
            let dateFormat = ISO8601DateFormatter()
            var data: Dictionary<String, String> = [
                "timeStamp": dateFormat.string(from: Date()),
                "userToken": UserDefaults.standard.string(forKey: "USERTOKEN") ?? "",
                "gameStatus": "Deactivated",
                "gameName": "MemoryGame",
            ]
            self.fileHandler.writeToFile(dataToWrite: &data)
        })
    }
}

struct CardView: View {
    var card : MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader{ geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp).padding(5)
            .transition(.scale)
        }
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}

struct MemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryGameView()
    }
}
