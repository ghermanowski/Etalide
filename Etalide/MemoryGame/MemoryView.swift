//
//  MemoryView.swift
//  Etalide
//
//  Created by Alessia Andrisani on 24/05/22.
//

import SwiftUI

struct MemoryView: View {
	
	@StateObject var cardStore = CardStore()
	
	
	let columns = Array(repeating: GridItem(.flexible(maximum: UIScreen.main.bounds.height / 5)), count: 4)
	
	@State private var isFaceUp = false
	
	var body: some View {
		LazyVGrid(columns: columns, spacing: 30) {
			ForEach(cardStore.duplicatedCards) { card in
				if cardStore.hiddenCards.contains(card) {
					Spacer()
				} else {
					TestCardView(card: card, selectedCards: $cardStore.selectedCards)
						.aspectRatio(2/3, contentMode: .fit)
						.padding()
				}
			}
		}
		.onAppear {
			cardStore.createGame()
		}
		.onChange(of: cardStore.selectedCards.count) { _ in
			if cardStore.selectedCards.count == 2 {
				cardStore.checkPair()
			}
		}
	}
}

struct MemoryView_Previews: PreviewProvider {
	static var previews: some View {
		MemoryView()
			.previewInterfaceOrientation(.portrait)
	}
}
