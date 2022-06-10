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
	@Environment(\.managedObjectContext) private var moc
    
    private let deck: Deck
    
    @Binding private var isShowingPopover: Bool
	
	@State private var isShowingDifficulties = false
	@State private var selectedCard: Card?
	@State private var showNewCardView = false
	@State private var isDeletionRequested = false
    
	@ViewBuilder private func cardView(_ card: Card) -> some View {
		if let imageURL = card.imageURL {
			Button {
				selectedCard = card
			} label: {
				CardImageView(imageURL)
					.cornerRadius(15)
			}
			.buttonStyle(.verticalRectangle)
		}
	}
	
	@ViewBuilder private var cardGrid: some View {
		let columns = Array(
			repeating: GridItem(spacing: 16),
			count: isLandscape ? 4 : 3
		)
		
		ScrollView(showsIndicators: false) {
			LazyVGrid(columns: columns, spacing: 16) {
				if let cards = deck.allCards {
					ForEach(cards) { card in
						cardView(card)
					}
				}
			}
		}
	}
	
	var gameSelection: some View {
		VStack(spacing: 20) {
			if let cards = deck.cards, cards.count >= MemoryDifficulty.easy.amount {
				Button {
					withAnimation{
						isShowingDifficulties = true
					}
				} label: {
					ButtonView(imageTitle: "MemoryGameButton", title: "Play Memory")
				}
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
			if let cards = deck.allCards, !cards.isEmpty {
				GeometryReader { geometry in
					HStack(alignment: .center, spacing: 40) {
						cardGrid
							.frame(width: geometry.size.width * 0.5)
						
						Divider()
							.frame(width: 1.5)
							.background(Color.accentColor)
							.padding(.vertical, 20)
							.padding(.bottom, 20)
						
						gameSelection
					}
					.padding(.vertical, 32)
					.padding(.horizontal, isLandscape ? 64 : 32)
				}
			} else {
				Text("Tap \(Image(systemName: "plus.circle.fill")) to add a card.")
					.font(.largeTitle.weight(.semibold))
					.foregroundColor(.accentColor)
			}
        }
		.padding(.top, 96)
		.frame(width: UIScreen.main.bounds.width * (isLandscape ? 0.85 : 0.95),
			   height: UIScreen.main.bounds.height * (isLandscape ? 0.75 : 0.65))
        .background(.white)
		.navigationButtons(alignment: .topLeading) {
			Button(action: dismiss) {
				Image(systemName: "xmark")
			}
			.buttonStyle(.circle)
		}
		.navigationButtons(alignment: .top) {
			Text(deck.localisedName ?? deck.wrappedName)
				.font(.system(.largeTitle).weight(.semibold))
				.foregroundColor(.accentColor)
		}
		.navigationButtons(alignment: .topTrailing) {
			Button(role: .destructive) {
				isDeletionRequested = true
			} label: {
				Image(systemName: "trash")
			}
			.buttonStyle(.circle)
			.confirmationDialog("Are you sure you want to delete this deck?", isPresented: $isDeletionRequested, titleVisibility: .visible) {
				Button("Delete", role: .destructive, action: deleteDeck)
			}
			
			Button {
				showNewCardView.toggle()
			} label: {
				Image(systemName: "plus")
			}
			.buttonStyle(.circle)
		}
		.overlay {
			if selectedCard != nil || showNewCardView {
				CardPopupView(
					selectedCard,
					deck: deck,
					showPopover: Binding(
						get: { selectedCard != nil || showNewCardView },
						set: { _ in
							selectedCard = nil
							showNewCardView = false
						}
					)
				)
			}
		}
		.cornerRadius(40)
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(Color.primary.opacity(0.75))
    }
	
	private func dismiss() {
		isShowingPopover = false
	}
	
	private func deleteDeck() {
		moc.delete(deck)
		saveContext()
		dismiss()
	}
	
	private func saveContext() {
		do {
			try moc.save()
		} catch {
			// TODO: Add error handling
			fatalError(error.localizedDescription)
		}
	}
}

struct DeckPopoverView_Previews: PreviewProvider {
    static var previews: some View {
        DeckPopoverView(Deck(), isShowingPopover: .constant(true))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
