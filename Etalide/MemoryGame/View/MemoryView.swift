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
	
	@State private var showingCards = false
	
	var body: some View {
		let padding: CGFloat = 24
		
		let columns = Array(
			repeating: GridItem(.flexible(maximum: UIScreen.main.bounds.width / (isLandscape ? 5 : 2.5)), spacing: padding),
			count: isLandscape ? difficulty.horizontalColumns : difficulty.verticalColumns
		)
		
		VStack {
			if cardStore.hiddenCards.isEmpty || cardStore.duplicatedCards.count != cardStore.hiddenCards.count {
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
				.animation(nil, value: cardStore.duplicatedCards.count != cardStore.hiddenCards.count)
			} else {
				ZStack {
					Text("Well Done!")
						.foregroundColor(.backgroundBlue)
						.font(.system(size: 100, weight: .semibold))
					
					Circle()
						.fill(Color.blue)
						.frame(width: 12, height: 12)
						.modifier(ParticlesModifier())
						.offset(x: -100, y : -50)
					
					Circle()
						.fill(Color.red)
						.frame(width: 12, height: 12)
						.modifier(ParticlesModifier())
						.offset(x: 60, y : 70)
					
					Circle()
						.fill(Color.green)
						.frame(width: 12, height: 12)
						.modifier(ParticlesModifier())
				}
				.transition(.opacity.animation(.default.delay(1)))
			}
		}
		.animation(.default, value: cardStore.duplicatedCards.count != cardStore.hiddenCards.count)
		.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
		.background(Color(uiColor: .systemBackground))
		.environmentObject(cardStore)
		.onAppear(perform: cardStore.createGame)
		.onChange(of: cardStore.selectedCards.count) { _ in
			if cardStore.selectedCards.count == 2 {
				Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
					cardStore.checkPair()
					
					Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
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
		.navigationButtons(alignment: .topTrailing) {
			Button {
				//Show all cards
				showingCards.toggle()
				
				for card in cardStore.duplicatedCards {
					if showingCards {
						
						cardStore.selectedCards.append(card)
						
					} else {
						cardStore.selectedCards.removeAll()
					}
				}
			} label: {
				Image(systemName: "eye.circle.fill")
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
