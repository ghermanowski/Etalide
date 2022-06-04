//
//  MemoryView.swift
//  Etalide
//
//  Created by Alessia Andrisani on 24/05/22.
//

import SwiftUI

struct MemoryView: View {
	init(deck: Deck) {
		_cardStore = StateObject(wrappedValue: CardStore(deck: deck))
	}
	
	@StateObject var cardStore: CardStore
	
	@State private var orientation = UIDeviceOrientation.unknown
	
	var body: some View {
		let columns = Array(repeating: GridItem(.flexible()), count: orientation.isPortrait ? 4 : 6)
		
		LazyVGrid(columns: columns, spacing: 30) {
			ForEach(cardStore.duplicatedCards) { card in
				// Hides the cards when they match.
				let isHidden = cardStore.hiddenCards.contains(card)
				
				TestCardView(card)
					.opacity(isHidden ? 0 : 1)
					.animation(.default, value: isHidden)
			}
		}
		.environmentObject(cardStore)
        .onRotate { newOrientation in
			orientation = newOrientation
		}
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
		MemoryView(deck: Deck())
			.previewInterfaceOrientation(.portrait)
	}
}
