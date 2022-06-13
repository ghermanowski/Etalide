//
//  CardGameView.swift
//  Etalide
//
//  Created by Galina Aleksandrova on 16/05/22.
//

import SwiftUI

struct CardGameView: View {
    init(_ deck: Deck) {
        self.deck = deck
		_cards = State(initialValue: deck.allCards!.shuffled())
    }
    
	@Environment(\.dismiss) private var dismiss
	
    @State var cards: [Card]
	@State var previousCards = [Card]()
	@State var isShowingAlert = false
    
    private let deck: Deck
    
    var body: some View {
        VStack {
			if !cards.isEmpty {
				ZStack {
					ForEach(cards, id: \.self) { card in
						SwipableCardView(card: card) {
							withAnimation(.interactiveSpring()) {
								guard let card = cards.popLast() else { return }
								previousCards.append(card)
							}
						}
					}
				}
			} else {
				Button {
					cards.append(contentsOf: deck.allCards!.shuffled())
					previousCards.removeAll()
				} label: {
					GameButton(imageTitle: "FlashcardButton", title: String(localized: "Play again"))
						.frame(height: UIScreen.main.bounds.height * 0.2)
				}
				.buttonStyle(.scalesOnPress)
			}
        }
        .padding(64)
		.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
		.background(Color.background)
		.overlay {
			if isShowingAlert {
				InfoAlert(isShowingAlert: $isShowingAlert)
			}
		}
		.statusBar(hidden: true)
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
				isShowingAlert = true
			} label: {
				Image(systemName: "questionmark")
			}
			.buttonStyle(.circle)
		}
		.navigationButtons(alignment: .bottomLeading) {
			if let lastCard = previousCards.last {
				Button {
					cards.append(lastCard)
					previousCards.removeLast()
				} label: {
					Image(systemName: "arrowshape.turn.up.backward")
				}
				.buttonStyle(.circle)
			}
		}
	}
}

struct CardGameView_Previews: PreviewProvider {
	static var deck = Deck()
	
	static var previews: some View {
		CardGameView(deck)
	}
}
