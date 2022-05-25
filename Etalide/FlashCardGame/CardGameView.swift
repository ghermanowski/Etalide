//
//  ContentView.swift
//  SwipeTinder
//
//  Created by Galina Aleksandrova on 16/05/22.
//

import SwiftUI

var cards = [Card]()

struct CardGameView: View {
   
    
    func getCardOffset(_ geometry: GeometryProxy, id: UUID) -> CGFloat {
            return  CGFloat(cards.count) * 10
        }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                VStack {
                    ZStack {
                        ForEach(cards, id: \.self) { card in
                            //TODO: to display only 2 cards, later when has proper CardView
                           // if card.id > cardStore.maxID - 2 {
                                SwipableCardView(card: card, onRemove:
                                            
                                            withAnimation(.interactiveSpring()) {
                                    { removedCard in
                                        // Remove that card from our array
                                        cards.removeAll { $0.id == removedCard.id }
                                    }
                                }
                                )
                            //force unwrap for now
                                .offset(x:0, y: getCardOffset(geometry, id: card.id!))
                           // }
                            
                        }
                        if cards.isEmpty {
                            Button {
                                //start game over again
                                cards.append(contentsOf: cards)
                            } label: {
                                VStack (alignment: .leading) {
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


