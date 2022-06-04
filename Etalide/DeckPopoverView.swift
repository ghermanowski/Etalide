//
//  DeckPopoverView.swift
//  Etalide
//
//  Created by Galina Aleksandrova on 26/05/22.
//

import SwiftUI

struct DeckPopoverView: View {
    init(_ deck: Deck, isShowingPopover: Binding<Bool>) {
        self.deck = deck
        self._isShowingPopover = isShowingPopover
    }
    
    private let deck: Deck
    
    @Binding var isShowingPopover: Bool
    
    var body: some View {
        VStack (alignment: .center) {
            HStack {
                Spacer()
                
                Text(deck.wrappedName)
                    .font(.system(.largeTitle))
                    .bold()
                    .foregroundColor(.backgroundBlue)
                
                Spacer()
                
                Button {
                    isShowingPopover = false
                } label: {
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.backgroundBlue)
                        .font(.system(.largeTitle))
                }
            }
            
            GeometryReader { geometry in
                HStack (alignment: .center, spacing: 40) {
                    // Card preview view
                    
                    DeckOfCardsView(deck)
                        .frame(width: geometry.size.width * 0.5, height: geometry.size.height)
                        .padding()
                    
                    Divider()
                        .frame(height: geometry.size.height * 0.7)
                    // Buttons view
                    VStack {
                        NavigationLink {
                            MemoryView(deck: deck)
                        } label: {
                            ButtonView(imageTitle: "MemoryGameButton", title: "Play Memory")
                        }
                        
                        NavigationLink {
							CardGameView(deck)
                        } label: {
                            ButtonView(imageTitle: "FlashcardButton", title: "Play FlashCards")
                        }
					}
                }
			}
        }
        .padding()
        .background(.white)
        .cornerRadius(35)
    }
}

struct DeckPopoverView_Previews: PreviewProvider {
    static var previews: some View {
        DeckPopoverView(Deck(), isShowingPopover: .constant(true))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
