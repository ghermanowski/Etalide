//
//  InfoAlert.swift
//  Etalide
//
//  Created by Antonio Scognamiglio on 10/06/22.
//

import SwiftUI

struct InfoAlert: View {
	@Binding var isShowingAlert: Bool
	
	var body: some View {
		VStack(spacing: 32) {
			Text("Instructions")
				.fontWeight(.bold)
				.font(.largeTitle)
			
			Text("""
   Swipe horizontally to see the next card.
   Tap on the card to reveal the entire word.
   """)
			.font(.title2)
			.fontWeight(.medium)
			.multilineTextAlignment(.leading)
			.lineSpacing(5)
			.padding(.bottom, 8)
			
			Button(action: {
				self.isShowingAlert.toggle()
			} ) {
				Text("OK")
					.padding(.horizontal, 40)
					.padding(.vertical)
					.font(.title2.weight(.bold))
					.foregroundColor(.background2)
					.background(Capsule())
			}
		}
		.padding(32)
		.background {
			RoundedRectangle(cornerRadius: 45, style: .continuous)
				.fill(Color.background2)
				.shadow(radius: 5)
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
}

struct InfoAlert_Previews: PreviewProvider {
	static var previews: some View {
		InfoAlert(isShowingAlert: .constant(true))
	}
}
