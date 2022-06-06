//
//  DeckOfCardsView.swift
//  Etalide
//
//  Created by Galina Aleksandrova on 26/05/22.
//

import SwiftUI

struct DeckOfCardsView: View {
	init(_ deck: Deck) {
        self.deck = deck
    }
    
	@EnvironmentObject private var orientationManager: OrientationManager
	
    private let deck: Deck
    
    var body: some View {
		let columns = Array(
			repeating: GridItem(),
			count: orientationManager.isLandscape ? 4 : 3
		)
		
        LazyVGrid(columns: columns) {
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
