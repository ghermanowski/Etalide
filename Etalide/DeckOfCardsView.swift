//
//  DeckOfCardsView.swift
//  Etalide
//
//  Created by Galina Aleksandrova on 26/05/22.
//

import SwiftUI

struct DeckOfCardsView: View {
    
    let gridItemLayot = Array(repeating: GridItem(.flexible(maximum: UIScreen.main.bounds.width)), count: 4)
    
    init(_ deck: Deck) {
        self.deck = deck
    }
    
    private let deck: Deck
    
    var body: some View {
        
        LazyVGrid (columns: gridItemLayot) {
            if let cards = deck.allCards {
                ForEach(cards) { card in
                    CardView(card, in: deck)
                        .aspectRatio(2/3, contentMode: .fit)
                        
                        .padding()
                }
            }
//            ForEach(0..<12) { number in
//                ZStack {
//                    Color
//                        .purple
//                    Text("\(number)")
//                }
//                .aspectRatio(2/3, contentMode: .fit)
//
//                .padding()
//            }
        }
    }
}

struct DeckOfCardsView_Previews: PreviewProvider {
    static var previews: some View {
        DeckOfCardsView(Deck())
    }
}
