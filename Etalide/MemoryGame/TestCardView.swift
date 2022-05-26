//
//  TestCardView.swift
//  Etalide
//
//  Created by Alessia Andrisani on 24/05/22.
//

import SwiftUI

struct TestCardView: View {
	let card: TestCard
	private let animationDuration = 0.35
	
	@EnvironmentObject var cardStore: CardStore
	
	@State private var isRotated = false
	
	var body: some View {
		let isSelected = cardStore.selectedCards.contains(card)
		
		ZStack {
			let shape = RoundedRectangle(cornerRadius:20)
			
			if isRotated {
				shape
					.fill()
					.foregroundColor(.white)
				
				shape
					.strokeBorder(lineWidth: 3)
					.foregroundColor(.indigo)
				
				Text(card.emoji)
					.font(.system(size: 100))
					.rotation3DEffect(.degrees(180),
									  axis: (x: 0, y: 1, z: 0))
			} else {
				shape.fill().foregroundColor(.indigo)
			}
		}
		.rotation3DEffect(.degrees(isSelected ? 180 : 0),
						  axis: (x: 0, y: 1, z: 0))
		.animation(.linear(duration: animationDuration), value: isSelected)
		.onChange(of: isSelected) { isSelected in
			withAnimation(.linear(duration: 0.0001).delay(animationDuration / 2)) {
				isRotated = isSelected
			}
		}
		.onTapGesture {
			if cardStore.selectedCards.count < 2 {
				if !isSelected {
					cardStore.selectedCards.append(card)
				}
			}
		}
	}	
}

struct TestCardView_Previews: PreviewProvider {
    static var previews: some View {
		TestCardView(card: .example)
			.environmentObject(CardStore())
    }
}
