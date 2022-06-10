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
    
	@ViewBuilder private var cardGrid: some View {
		let columns = Array(
			repeating: GridItem(spacing: 16),
			count: isLandscape ? 4 : 3
		)
		
		ScrollView {
			LazyVGrid(columns: columns, spacing: 16) {
				if let cards = deck.allCards {
					ForEach(cards) { card in
						if let imageURL = card.imageURL {
							CardImageView(imageURL)
								.cornerRadius(15)
						}
					}
				}
			}
		}
	}
	
	var gameSelection: some View {
		VStack(spacing: 20) {
			Button {
				withAnimation{
					isShowingDifficulties = true
				}
			} label: {
				ButtonView(imageTitle: "MemoryGameButton", title: "Play Memory")
			}
			
			NavigationLink {
				CardGameView(deck)
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
	
    var body: some View {
        VStack {
			Text(deck.localisedName ?? deck.wrappedName)
				.font(.system(.largeTitle))
				.bold()
				.foregroundColor(.accentColor)
				.padding([.top, .horizontal], 32)
				.frame(maxWidth: .infinity)
            
            GeometryReader { geometry in
                HStack(alignment: .center, spacing: 40) {
					cardGrid
						.frame(width: geometry.size.width * 0.45)
                    
                    Divider()
						.frame(width: 1.5)
						.background(Color.accentColor)
						.padding(.vertical, 20)
                    
					gameSelection
                }
				.padding(.vertical, 32)
				.padding(.horizontal, isLandscape ? 64 : 32)
			}
        }
		.frame(width: UIScreen.main.bounds.width * (isLandscape ? 0.85 : 0.95),
			   height: UIScreen.main.bounds.height * (isLandscape ? 0.75 : 0.65))
        .background(.white)
        .cornerRadius(40)
		.navigationButtons(alignment: .topLeading) {
			Button {
				isShowingPopover = false
			} label: {
				Image(systemName: "xmark")
			}
			.buttonStyle(.circle)
		}
		.navigationButtons(alignment: .topTrailing) {
			NavigationLink {
				DeckView(deck)
			} label: {
				Image(systemName: "info")
			}
			.buttonStyle(.circle)
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(Color.primary.opacity(0.75))
    }
}

struct DeckPopoverView_Previews: PreviewProvider {
    static var previews: some View {
        DeckPopoverView(Deck(), isShowingPopover: .constant(true))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
