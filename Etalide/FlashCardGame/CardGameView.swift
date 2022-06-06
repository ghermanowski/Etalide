//
//  CardGameView.swift
//  Etalide
//
//  Created by Galina Aleksandrova on 16/05/22.
//

import SwiftUI

struct CardGameView: View {
    
    init(_ deck: Deck, cards: [Card]) {
        self.deck = deck
        self.cards = deck.allCards!
    }
    
    @State var cards: [Card]
    
    private let deck: Deck
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                VStack {
                    ZStack {
                        
                        ForEach(cards, id: \.self) { card in
                            SwipableCardView(card: card, onRemove: withAnimation(.interactiveSpring()) {
                                { removedCard in
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
                                        
                                        ButtonView(imageTitle: "FlashcardButton", title: String(localized: "Play again"))
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
        .padding()
		.navigationBarTitle("Flashcards")
		.navigationBarTitleDisplayMode(.inline)
    }
}

struct CardGameView_Previews: PreviewProvider {
    
    static var deck = Deck()
    static var previews: some View {
        CardGameView(deck, cards: deck.allCards!)
    }
}
