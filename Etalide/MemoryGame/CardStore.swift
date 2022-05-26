//
//  CardStore.swift
//  Etalide
//
//  Created by Alessia Andrisani on 25/05/22.
//

import Foundation
import SwiftUI

class CardStore: ObservableObject {
	@Published var cards: [TestCard] = [card1, card2, card3, card4, card5, card6]
	
	@Published var duplicatedCards: [TestCard] = []
	@Published var hiddenCards: [TestCard] = []
	@Published var selectedCards: [TestCard] = []
	
	func createGame() {
		for card in cards {
			var newCard = card
			newCard.id = UUID()
			duplicatedCards.append(newCard)
			duplicatedCards.append(card)
		}
		
		duplicatedCards.shuffle()
	}
	
	func checkPair() {
		if selectedCards[0].emoji == selectedCards[1].emoji {
			print("Correct!!!!!")
			
			hiddenCards += duplicatedCards.filter { selectedCards[0].emoji == $0.emoji }
		}
	}
}



let card1 = TestCard(id: UUID(), emoji: "🚀")
let card2 = TestCard(id: UUID(), emoji: "🚔")
let card3 = TestCard(id: UUID(), emoji: "🚖")
let card4 = TestCard(id: UUID(), emoji: "✈️")
let card5 = TestCard(id: UUID(), emoji: "🚑")
let card6 = TestCard(id: UUID(), emoji: "🚌")
