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
		.onTapGesture {
			if selectedCards.count < 2 {
				if !selectedCards.contains(card) {
					selectedCards.append(card)
				}
			}
		}
	}
}

struct TestCardView_Previews: PreviewProvider {
    static var previews: some View {
		TestCardView(card: .example, selectedCards: .constant([.example]))
    }
}
