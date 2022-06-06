//
//  DeckPreview.swift
//  Etalide
//
//  Created by Gregor Hermanowski on 02/06/22.
//

import SwiftUI

struct DeckPreview: View {
	init(_ deck: Deck) {
		self.deck = deck
	}
	
	private let deck: Deck
	
    var body: some View {
		Group {
			if let firstCard = deck.allCards?.min(),
			   let imageURL = firstCard.imageURL {
				CardImageView(imageURL)
			} else {
				Color(uiColor: .secondarySystemBackground)
			}
		}
		.cornerRadius(25)
		.overlay {
			Text(deck.wrappedName)
				.font(.largeTitle.bold())
				.foregroundColor(.white)
				.shadow(color: .black.opacity(0.5), radius: 5)
		}
    }
}

struct DeckPreview_Previews: PreviewProvider {
    static var previews: some View {
		DeckPreview(Deck())
    }
}
