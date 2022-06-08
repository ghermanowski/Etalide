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
		let padding: CGFloat = 24
		
		let columns = Array(
			repeating: GridItem(.flexible(maximum: UIScreen.main.bounds.width / (isLandscape ? 5 : 2.5)), spacing: padding),
			count: isLandscape ? difficulty.horizontalColumns : difficulty.verticalColumns
		)
		
		VStack {
			LazyVGrid(columns: columns, spacing: padding) {
				ForEach(cardStore.duplicatedCards.indices, id: \.self) { cardIndex in
					let card = cardStore.duplicatedCards[cardIndex]
					let isHidden = cardStore.hiddenCards.contains(card)
					
					MemoryCardView(card, position: cardIndex + 1)
						.opacity(isHidden ? 0 : 1)
						.animation(.default, value: isHidden)
				}
			}
			.padding(padding)
		}
		.frame(height: UIScreen.main.bounds.height)
		.background(Color(uiColor: .systemBackground))
		.environmentObject(cardStore)
		.onAppear(perform: cardStore.createGame)
		.onChange(of: cardStore.selectedCards.count) { _ in
			if cardStore.selectedCards.count == 2 {
				Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
					cardStore.checkPair()
					
					Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
						withAnimation {
							cardStore.selectedCards.removeAll()
						}
					}
				}
			}
		}
		.navigationBarHidden(true)
		.navigationButtons(alignment: .topLeading) {
			Button {
				dismiss()
			} label: {
				Image(systemName: "chevron.left")
			}
			.buttonStyle(.circle)
		}
	}
}

struct MemoryView_Previews: PreviewProvider {
	static var previews: some View {
		MemoryView(deck: Deck(), difficulty: .medium)
			.previewInterfaceOrientation(.portrait)
	}
}
