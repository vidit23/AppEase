//
//  EmojiMemoryGame.swift
//  Testing WatchKit Extension
//
//  Created by Vidit Bhargava on 11/19/20.
//

import Foundation
import SwiftUI

// ViewModel: portal for view to get model
// ViewModel never talks to its View(that's why no View related stuff in ViewModel class), it's the View talks to its ViewModel
// Many views may use the same ViewModel, that's why it's a class(reference)
class EmojiMemoryGame: ObservableObject {
    
    // You should never name a variable "model", here's teaching purpose, name it "game" instead
    // "portal/doorway" for the view
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    var cardsLeft: Int {
        model.cardsLeft
    }
    
    var newGameStart: Bool {
        model.newGameStart
    }
    
    static private func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["😎", "👻", "🎃", "🕷", "🥲", "🥳"]
        return MemoryGame<String>(numberOfPairsOfCard: emojis.count) { pairIndex in emojis[pairIndex]}
    }
    
    // (User) Intent
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func resetGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
