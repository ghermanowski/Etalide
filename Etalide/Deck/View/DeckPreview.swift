//
//  DeckPreview.swift
//  Etalide
//
//  Created by Gregor Hermanowski on 02/06/22.
//

import SwiftUI

struct DeckPreview: View {
	init(_ deck: Deck) {
		self.deck = deck
	}
	
	@Environment(\.editMode) private var editMode
	@Environment(\.managedObjectContext) private var moc
	
	private let deck: Deck
	
	@ViewBuilder func cardView(_ card: Card?) -> some View {
		Group {
			if let imageURL = card?.imageURL {
				CardImageView(imageURL)
			} else {
				Color.backgroundBlue
					.aspectRatio(3 / 4, contentMode: .fit)
			}
		}
		.cornerRadius(25)
	}
	
    var body: some View {
		Group {
			if let firstCards = deck.allCards?.sorted().prefix(3) {
				ZStack {
					cardView(firstCards.count >= 2 ? firstCards[1] : nil)
						.opacity(0.8)
						.offset(x: 10, y: 20)
						.padding([.trailing, .bottom], 10)
						.rotationEffect(.degrees(3.5), anchor: .bottomTrailing)
					
					cardView(firstCards.count >= 1 ? firstCards[0] : nil)
						.padding([.trailing, .bottom], 10)
				}
			}
		}
		.overlay {
			Text(deck.localisedName ?? deck.wrappedName)
				.font(.largeTitle.bold())
				.foregroundColor(.white)
				.shadow(color: .black.opacity(0.5), radius: 5)
		}
		.navigationButtons(alignment: .topTrailing) {
			if editMode?.wrappedValue == .active {
				Button(role: .destructive, action: deleteDeck) {
					Label("Delete", systemImage: "trash")
						.labelStyle(.iconOnly)
				}
				.buttonStyle(.circle)
			}
		}
	}
	
	private func deleteDeck() {
		moc.delete(deck)
		saveContext()
	}
	
	private func saveContext() {
		do {
			try moc.save()
		} catch {
			fatalError(error.localizedDescription)
		}
	}
}

struct DeckPreview_Previews: PreviewProvider {
    static var previews: some View {
		DeckPreview(Deck())
    }
}
