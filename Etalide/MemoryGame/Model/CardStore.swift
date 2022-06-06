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
				.map { MemoryCard(id: $0.id!, imageURL: $0.imageURL!) }
				.shuffled()
				.prefix(difficulty.amount)
		)
	}
	
	@Published var cards: [MemoryCard]
	@Published var duplicatedCards: [MemoryCard] = []
	@Published var hiddenCards: [MemoryCard] = []
	@Published var selectedCards: [MemoryCard] = []
	
	// Creates duplicated cards from the cards array.
	func createGame() {
		var duplicatedCards = cards + cards.map { MemoryCard(id: UUID(), imageURL: $0.imageURL) }
		duplicatedCards.shuffle()
		self.duplicatedCards = duplicatedCards
	}
	
	// Check is the cards selected match.
	func checkPair() {
		if selectedCards[0].imageURL == selectedCards[1].imageURL {
			hiddenCards += duplicatedCards.filter { selectedCards[0].imageURL == $0.imageURL }
		}
	}
}
