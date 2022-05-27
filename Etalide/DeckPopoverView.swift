//
//  DeckPopoverView.swift
//  Etalide
//
//  Created by Galina Aleksandrova on 26/05/22.
//

import SwiftUI

struct DeckPopoverView: View {
    init(_ deck: Deck) {
        self.deck = deck
    }
    
    private let deck: Deck
//    @Binding var isShowingPopover: Bool
    var body: some View {
    
        NavigationView {
        VStack (alignment: .center) {
            HStack {
                
                Spacer()
                
                Text("Animals")
                    .font(.system(.largeTitle))
                
                Spacer()
                
                Button {
//                    isShowingPopover = false
                } label: {
                    Image(systemName: "x.circle.fill")
                }
            }
       
            
            GeometryReader { geometry in
                HStack (alignment: .center, spacing: 40) {
                    // Card preview view
                   
                    DeckOfCardsView(deck)
                        .frame(width: geometry.size.width * 0.5, height: geometry.size.height)
                        .background(.brown)
                   
                    Divider()
                        .frame(height: geometry.size.height * 0.7)
                    // Buttons view
                    VStack {
                        NavigationLink {
                            // navigate to memory game view
                        } label: {
                            ButtonView(title: "Play Memory")
                        }
                        
                        NavigationLink {
                            CardGameView(deck)
                        } label: {
                            ButtonView(title: "Play FlashCards")
                        }                    }
                    .frame(width: geometry.size.width * 0.4, height: geometry.size.height * 0.5)
                    
                }            }
        }
        }
        .padding()
        
        .background(.cyan)
    }
}

struct DeckPopoverView_Previews: PreviewProvider {
    static var previews: some View {
        DeckPopoverView(Deck())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
