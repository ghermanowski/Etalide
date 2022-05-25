//
//  CardGameView.swift
//  Etalide
//
//  Created by Galina Aleksandrova on 16/05/22.
//

import SwiftUI

struct CardGameView: View {
    @State var cards = [Card]()
    
    func getCardOffset(_ geometry: GeometryProxy, id: UUID) -> CGFloat {
        CGFloat(cards.count) * 10
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                VStack {
                    ZStack {
                        ForEach(cards, id: \.self) { card in
                            // TODO: to display only 2 cards, later when has proper CardView
                            // if card.id > cardStore.maxID - 2 {
                            SwipableCardView(card: card) { removedCard in
                                withAnimation(.interactiveSpring()) {
                                    // Remove that card from our array
                                    cards.removeAll { $0.id == removedCard.id }
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
                    
                    Spacer()
                }
            }
        }
        .padding()
    }
}


