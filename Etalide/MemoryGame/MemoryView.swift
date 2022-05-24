//
//  MemoryView.swift
//  Etalide
//
//  Created by Alessia Andrisani on 24/05/22.
//

import SwiftUI

struct MemoryView: View {
	var emojis: [String] = ["🚀","🚔", "🚖","✈️", "🚑", "🚌"]
	
	@State private var emojiPairs: [String] = []
	
	
	let columns = [
		//		GridItem(.adaptive(minimum: UIScreen.main.bounds.height / 6.5))
		GridItem(.flexible(maximum: UIScreen.main.bounds.height / 5)),
		GridItem(.flexible(maximum: UIScreen.main.bounds.height / 5)),
		GridItem(.flexible(maximum: UIScreen.main.bounds.height / 5)),
		GridItem(.flexible(maximum: UIScreen.main.bounds.height / 5))
		
	]
	
	var body: some View {
		LazyVGrid(columns: columns, spacing: 30) {
			ForEach(emojiPairs.indices, id: \.self) { emojiIndex in
				TestCardView(content: emojiPairs[emojiIndex])
					.aspectRatio(2/3, contentMode: .fit)
					.padding()
			}
		}
		.onAppear {
			createGame()
		}
	}
	func createGame() {
		
		emojiPairs = emojis + emojis
		
		emojiPairs.shuffle()
	}
}

struct MemoryView_Previews: PreviewProvider {
	static var previews: some View {
		MemoryView()
			.previewInterfaceOrientation(.portrait)
	}
}
