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
	
	@Environment(\.isLandscape) private var isLandscape
    
    private let deck: Deck
    
    @Binding var isShowingPopover: Bool
	
	@State var isShowingDifficulties: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
				NavigationLink {
					DeckView(deck)
				} label: {
					Image(systemName: "pencil.circle.fill")
						.foregroundColor(.backgroundBlue)
						.font(.system(.largeTitle).weight(.semibold))
				}
				
                Button {
                    isShowingPopover = false
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
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
				.padding(.horizontal, isLandscape ? 128 : 32)
			}
        }
        .background(.white)
        .cornerRadius(40)
		.padding(.vertical, isLandscape ? 32 : 160)
		.padding(.horizontal, isLandscape ? 64 : 32)
		.background(Color(uiColor: .secondarySystemBackground))
    }
}

struct DeckPopoverView_Previews: PreviewProvider {
    static var previews: some View {
        DeckPopoverView(Deck(), isShowingPopover: .constant(true))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
