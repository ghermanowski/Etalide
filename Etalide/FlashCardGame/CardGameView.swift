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
        _cards = State(initialValue: deck.allCards!)
    }
    
	@Environment(\.dismiss) private var dismiss
	
    @State var cards: [Card]
	@State var isShowingAlert = false
    
    private let deck: Deck
    
    var body: some View {
        VStack {
			GeometryReader { geometry in
                VStack {
                    ZStack {
                        
                        ForEach(cards, id: \.self) { card in
                            SwipableCardView(card: card, onRemove:
                                { removedCard in
                                withAnimation(.interactiveSpring()) {
                                    cards.removeAll { $0.id == removedCard.id}
                                }
                            }
                            )
                            
                        }
                        
                        if cards.isEmpty {
                            Button {
                                cards.append(contentsOf: deck.allCards!)
                            } label: {
                                
                                VStack {
                                    Spacer()
                                    
                                    HStack {
                                        Spacer()
                                        
                                        GameButton(imageTitle: "FlashcardButton", title: String(localized: "Play again"))
                                            .frame(width: UIScreen.main.bounds.width * 0.40, height: UIScreen.main.bounds.height * 0.45)
                                        
                                        Spacer()
                                    }
                                    
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                
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
		
	}
}

struct CardGameView_Previews: PreviewProvider {
	static var deck = Deck()
	
	static var previews: some View {
		CardGameView(deck)
	}
}
