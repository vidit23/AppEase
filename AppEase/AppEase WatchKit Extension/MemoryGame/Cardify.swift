//
//  Cardify.swift
//  Testing WatchKit Extension
//
//  Created by Vidit Bhargava on 11/19/20.
//

import Foundation
import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    func body(content: Content) -> some View {
        
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
            }
            else {
                RoundedRectangle(cornerRadius: fontScaleFactor).fill()
            }
        }
    }
    private let fontScaleFactor: CGFloat = 0.7
    private let cornerRadius: CGFloat = 8.0
    private let edgeLineWidth: CGFloat = 3
}

extension View {
    func cardify(isFaceUp: Bool ) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
