//
//  MemoryView.swift
//  Etalide
//
//  Created by Alessia Andrisani on 24/05/22.
//

import SwiftUI

struct MemoryView: View {
	init(deck: Deck, difficulty: MemoryDifficulty) {
		_cardStore = StateObject(wrappedValue: CardStore(deck: deck, difficulty: difficulty))
	}
	
	@EnvironmentObject private var orientationManager: OrientationManager
	
	@StateObject private var cardStore: CardStore
	
	var body: some View {
		let columns = Array(
			repeating: GridItem(.flexible()),
			count: orientationManager.isLandscape ? 6 : 4
		)
		
		LazyVGrid(columns: columns, spacing: 30) {
			ForEach(cardStore.duplicatedCards) { card in
				// Hides the cards when they match.
				let isHidden = cardStore.hiddenCards.contains(card)
				
				MemoryCardView(card)
					.opacity(isHidden ? 0 : 1)
					.animation(.default, value: isHidden)
			}
		}
		.environmentObject(cardStore)
		.onAppear(perform: cardStore.createGame)
		.onChange(of: cardStore.selectedCards.count) { _ in
			if cardStore.selectedCards.count == 2 {
				Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
					cardStore.checkPair()
					
					Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
						withAnimation {
							// Removes selected cards from the array.
							cardStore.selectedCards.removeAll()
						}
					}
				}
			}
		}
	}
}

struct MemoryView_Previews: PreviewProvider {
	static var previews: some View {
		MemoryView(deck: Deck(), difficulty: .medium)
			.previewInterfaceOrientation(.portrait)
	}
}
