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
		
		self.difficulty = difficulty
	}
	
	@Environment(\.dismiss) private var dismiss
	@Environment(\.isLandscape) private var isLandscape
	
	@StateObject private var cardStore: CardStore
	
	private let difficulty: MemoryDifficulty
	
	var body: some View {
		let padding: CGFloat = difficulty == .hard ? 12 : 24
		
		let columns = Array(
			repeating: GridItem(.flexible(), spacing: padding),
			count: isLandscape ? difficulty.columns : cardStore.duplicatedCards.count / difficulty.columns
		)
		
		LazyVGrid(columns: columns, spacing: padding) {
			ForEach(cardStore.duplicatedCards) { card in
				// Hides the cards when they match.
				let isHidden = cardStore.hiddenCards.contains(card)
				
				MemoryCardView(card)
					.opacity(isHidden ? 0 : 1)
					.animation(.default, value: isHidden)
			}
		}
		.padding(padding)
		.background(Color(uiColor: .systemBackground))
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
		.navigationBarHidden(true)
		.overlay(alignment: .topLeading) {
			Button {
				dismiss()
			} label: {
				Image(systemName: "chevron.left.circle.fill")
					.font(.largeTitle)
			}
			.padding(32)
		}
	}
}

struct MemoryView_Previews: PreviewProvider {
	static var previews: some View {
		MemoryView(deck: Deck(), difficulty: .medium)
			.previewInterfaceOrientation(.portrait)
	}
}
