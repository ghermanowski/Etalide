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
					if let imageURL = card.imageURL {
						CardImageView(imageURL)
							.cornerRadius(15)
					}
                }
            }
        }
    }
}

struct DeckOfCardsView_Previews: PreviewProvider {
    static var previews: some View {
        DeckOfCardsView(Deck())
    }
}
