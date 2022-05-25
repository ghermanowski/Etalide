//
//  TestCardView.swift
//  Etalide
//
//  Created by Alessia Andrisani on 24/05/22.
//

import SwiftUI

struct TestCardView: View {
	var card: TestCard
	
	@Binding var selectedCards: [TestCard]
	
	@State var rotationAmount: Double = 0.0
	
	@ObservedObject var cardStore: CardStore
	var body: some View {
		
		ZStack {
			let shape = RoundedRectangle(cornerRadius:20)
			
			
			if selectedCards.contains(card) {
				shape.fill().foregroundColor(.white)
				shape.strokeBorder(lineWidth: 3).foregroundColor(.indigo)
				Text(card.emoji).font(.system(size: 100))
			} else {
				shape.fill().foregroundColor(.indigo)
				
			}
		}
		.rotation3DEffect(.degrees(self.rotationAmount), axis: (x: 0, y: 1, z: 0))
		.onTapGesture {
			if selectedCards.count < 2 {
				if !selectedCards.contains(card) {
					withAnimation {
						rotationAmount += 180
						selectedCards.append(card)
					}
				}
			}
		}
		.onChange(of: selectedCards.count) { _ in
			if selectedCards.count == 2 && selectedCards.contains(card) {
				flipCardsBack()
			}
		}
	}
	
	func flipCardsBack() {
		
		Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
			withAnimation {
				rotationAmount -= 180
				self.selectedCards = []
			}
		}
	}	
}

struct TestCardView_Previews: PreviewProvider {
    static var previews: some View {
		TestCardView(card: .example, selectedCards: .constant([.example]), cardStore: CardStore())
    }
}
