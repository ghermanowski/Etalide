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
	
	@State var isShowingDifficulties: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button {
                    isShowingPopover = false
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.backgroundBlue)
						.font(.system(.largeTitle).weight(.semibold))
                }
            }
			.overlay {
				Text(deck.wrappedName)
					.font(.system(.largeTitle))
					.bold()
					.foregroundColor(.backgroundBlue)
			}
			.padding([.top, .horizontal], 32)
            
            GeometryReader { geometry in
                HStack(alignment: .center, spacing: 40) {
                    DeckOfCardsView(deck)
                        .frame(width: geometry.size.width * 0.4)
                    
                    Divider()
						.foregroundStyle(Color.backgroundBlue)
						.padding(.vertical, 20)
                    
					VStack(spacing: 20) {
						Button {
							withAnimation{
								isShowingDifficulties = true
							}
						} label: {
							ButtonView(imageTitle: "MemoryGameButton", title: "Play Memory")
						}
						
                        NavigationLink {
                            CardGameView(deck, cards: deck.allCards!)
                        } label: {
                            ButtonView(imageTitle: "FlashcardButton", title: String(localized: "Play FlashCards"))
                        }
					}
					.overlay {
						if isShowingDifficulties {
							SelectDifficultyView(deck: deck, isShowingDifficulties: $isShowingDifficulties)
						}
					}
                }
				.padding(.vertical, 32)
				.padding(.horizontal, 128)
			}
        }
        .background(.white)
        .cornerRadius(40)
    }
}

struct DeckPopoverView_Previews: PreviewProvider {
    static var previews: some View {
        DeckPopoverView(Deck(), isShowingPopover: .constant(true))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
