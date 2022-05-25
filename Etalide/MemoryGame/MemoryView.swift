//
//  MemoryView.swift
//  Etalide
//
//  Created by Alessia Andrisani on 24/05/22.
//

import SwiftUI

struct MemoryView: View {
	
	@StateObject var cardStore = CardStore()
	
	@State var selectedCards: [TestCard] = []
	@State var hiddenCards: [TestCard] = []
	
	let columns = Array(repeating: GridItem(.flexible(maximum: UIScreen.main.bounds.height / 5)), count: 4)
	
	@State private var isFaceUp = false
	
	var body: some View {
		LazyVGrid(columns: columns, spacing: 30) {
			ForEach(cardStore.duplicatedCards) { card in
				if hiddenCards.contains(card) {
					Spacer()
				} else {
					TestCardView(card: card, selectedCards: $selectedCards)
						.aspectRatio(2/3, contentMode: .fit)
						.padding()
				}
			}
		}
		.onAppear {
			cardStore.createGame()
		}
		.onChange(of: selectedCards.count) { _ in
			if selectedCards.count == 2 {
				checkPair()
			}
		}
	}
	func checkPair() {
		if selectedCards[0].emoji == selectedCards[1].emoji {
			print("Correct!!!!!")
			
			Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
				let cards = cardStore.duplicatedCards.filter { selectedCards[0].emoji == $0.emoji }
				
				hiddenCards += cards
			}
			
		} else {
			print("Oh noooo")
		}
		
		Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
			selectedCards = []
		}
	}
}

struct MemoryView_Previews: PreviewProvider {
	static var previews: some View {
		MemoryView()
			.previewInterfaceOrientation(.portrait)
	}
}
