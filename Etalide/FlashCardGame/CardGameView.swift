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
    }
    
    @State var cards = [Card]()
    
    private let deck: Deck
    
    func getCardOffset(_ geometry: GeometryProxy, id: UUID) -> CGFloat {
        CGFloat(cards.count) * 10
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                VStack {
                    ZStack {
                        if let cards = deck.allCards {
                            
                        
                        ForEach(cards, id: \.self) { card in
                            // TODO: to display only 2 cards, later when has proper CardView
                            // if card.id > cardStore.maxID - 2 {
                            SwipableCardView(card: card) { removedCard in
                                withAnimation(.interactiveSpring()) {
                                    // Remove that card from our array
                                    self.cards.removeAll { $0.id == removedCard.id }
                                }
                            }
                            // force unwrap for now
                            .offset(x:0, y: getCardOffset(geometry, id: card.id!))
                        }
                        
                        if cards.isEmpty {
                            Button {
                                // TODO: start game over again
//                                cards += cards
                            } label: {
                                VStack {
                                    Spacer()
                                    
                                    HStack {
                                        Spacer()
                                        
                                        Text("Play again")
                                        
                                        Spacer()
                                    }
                                    
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                    Spacer()
                }
            }
        }
        .padding()
    }
}

struct CardGameView_Previews: PreviewProvider {
    
    static var deck = Deck()
    static var previews: some View {
        CardGameView(deck)
    }
}
