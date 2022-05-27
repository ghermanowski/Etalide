//
//  MemoryView.swift
//  Etalide
//
//  Created by Alessia Andrisani on 24/05/22.
//

import SwiftUI

struct MemoryView: View {
	
	@StateObject var cardStore = CardStore()
    @State var columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 4)
	
	@State private var orientation = UIDeviceOrientation.unknown
    /// Specifying width and hight of the decks preview depending on the orientation of the device. The numbers are proportions of the available area (not absolute sizes)
    let cardWidthLandscape: CGFloat = 2/10
    let cardHeightLandscape: CGFloat = 2.7/10
    let cardWidthPortrait: CGFloat = 2.1/10
    let cardHeightPortrait: CGFloat = 2.1/10
	
	var body: some View {
		LazyVGrid(columns: columns, spacing: 30) {
			ForEach(cardStore.duplicatedCards) { card in
				// Hides the cards when they match.
				let isHidden = cardStore.hiddenCards.contains(card)
				
				TestCardView(card: card)
					.aspectRatio(2/3, contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width * (orientation.isLandscape ? cardWidthLandscape : cardWidthPortrait),
                         height: UIScreen.main.bounds.height * ( orientation.isLandscape ? cardHeightLandscape : cardHeightPortrait),
                         alignment: .center)
					.opacity(isHidden ? 0 : 1)
					.animation(.default, value: isHidden)
			}
		}
		.environmentObject(cardStore)
        .onRotate { newOrientation in
              orientation = newOrientation

          }
		.onAppear {
			cardStore.createGame()
		}
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
		MemoryView()
			.previewInterfaceOrientation(.portrait)
	}
}
