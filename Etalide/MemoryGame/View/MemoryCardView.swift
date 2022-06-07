//
//  MemoryCardView.swift
//  Etalide
//
//  Created by Alessia Andrisani on 24/05/22.
//

import SwiftUI

struct MemoryCardView: View {
	static private let animationDuration = 0.35
	
	internal init(_ card: MemoryCard, position: Int? = nil) {
		self.card = card
		self.position = position
	}
	
	@Environment(\.isLandscape) private var isLandscape
	
	private let card: MemoryCard
	private let position: Int?
	
	@EnvironmentObject private var cardStore: CardStore
	
	@State private var isRotated = false
	
	var body: some View {
		let isSelected = cardStore.selectedCards.contains(card)
		
		CardImageView(card.imageURL)
			.overlay {
				if !isRotated {
					Color.backgroundBlue
						.overlay {
							if let position = position {
								Text(verbatim: "\(position)")
									.foregroundStyle(.regularMaterial)
									.font(.system(size: isLandscape ? 80 : 96, weight: .bold, design: .serif))
							}
						}
				}
			}
			.cornerRadius(25)
			.rotation3DEffect(.degrees(isSelected ? 180 : 0),
							  axis: (x: 0, y: 1, z: 0))
			.animation(.linear(duration: Self.animationDuration), value: isSelected)
			.onChange(of: isSelected) { newValue in
				// The delay is needed to avoid seeing the content rotating and changing.
				withAnimation(.linear(duration: 0.0001).delay(Self.animationDuration / 2)) {
					isRotated = newValue
				}
			}
			.onTapGesture {
				// Selects up to 2 cards adding them to the array of selected cards.
				if !isSelected && cardStore.selectedCards.count < 2 {
					cardStore.selectedCards.append(card)
				}
			}
	}
}

struct MemoryCardView_Previews: PreviewProvider {
    static var previews: some View {
		MemoryCardView(MemoryCard(id: UUID(), imageURL: URL(string: "https://picsum.photos/300/400")!))
			.environmentObject(CardStore(deck: Deck(), difficulty: .medium))
    }
}
