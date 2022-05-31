//
//  DeckOfCardsView.swift
//  Etalide
//
//  Created by Galina Aleksandrova on 26/05/22.
//

import SwiftUI

struct DeckOfCardsView: View {
    
    @State var gridItemLayot = Array(repeating: GridItem(.flexible(maximum: UIScreen.main.bounds.width)), count: 3)
    //@State var columns = Array(repeating: GridItem(.flexible(),spacing: 20), count: 3)
    init(_ deck: Deck) {
        self.deck = deck
    }
    
    private let deck: Deck
    
    
    @State private var orientation = UIDeviceOrientation.unknown
    
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
        .onRotate { newOrientation in
            orientation = newOrientation
            if orientation.isLandscape {
                gridItemLayot = Array(repeating: GridItem(.flexible(maximum: UIScreen.main.bounds.width)), count: 4)
            } else {
                gridItemLayot = Array(repeating: GridItem(.flexible(maximum: UIScreen.main.bounds.width)), count: 3)
            }
        }
    }
}

struct DeckOfCardsView_Previews: PreviewProvider {
    static var previews: some View {
        DeckOfCardsView(Deck())
    }
}
