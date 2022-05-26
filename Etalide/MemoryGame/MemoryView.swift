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
	
	var body: some View {
		LazyVGrid(columns: columns, spacing: 30) {
			ForEach(cardStore.duplicatedCards) { card in
				let isHidden = cardStore.hiddenCards.contains(card)
				
				TestCardView(card: card)
					.aspectRatio(2/3, contentMode: .fit)
					.padding()
					.opacity(isHidden ? 0 : 1)
					.animation(.default, value: isHidden)
			}
		}
		.environmentObject(cardStore)
		.onAppear {
			cardStore.createGame()
		}
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
	}
}

struct MemoryView_Previews: PreviewProvider {
	static var previews: some View {
		MemoryView()
			.previewInterfaceOrientation(.portrait)
	}
}
