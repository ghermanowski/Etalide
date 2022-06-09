//
//  CardStore.swift
//  Etalide
//
//  Created by Alessia Andrisani on 25/05/22.
//

import Foundation
import SwiftUI

// ViewModel for MemoryGame.
class CardStore: ObservableObject {
	init(deck: Deck, difficulty: MemoryDifficulty) {
		cards = Array(
			deck.allCards!
				.shuffled()
				.prefix(difficulty.amount)
				.map { MemoryCard(id: $0.id!, imageURL: $0.imageURL!) }
		)
		
		let duplicatedCards = cards + cards.map { MemoryCard(id: UUID(), imageURL: $0.imageURL) }
		self.duplicatedCards = duplicatedCards.shuffled()
	}
	
	@Published var cards: [MemoryCard]
	@Published var duplicatedCards: [MemoryCard] = []
	@Published var hiddenCards: [MemoryCard] = []
	@Published var selectedCards: [MemoryCard] = []
	
	/// Checks if the selected cards match.
	func checkPair() {
		if selectedCards[0].imageURL == selectedCards[1].imageURL {
			hiddenCards += duplicatedCards.filter { selectedCards[0].imageURL == $0.imageURL }
		}
	}
}
