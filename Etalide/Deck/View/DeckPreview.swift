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
	
    var body: some View {
		Group {
			if let firstCard = deck.allCards?.min(),
			   let imageURL = firstCard.imageURL {
				CardImageView(imageURL)
			} else {
				Color(uiColor: .secondarySystemBackground)
			}
		}
		.cornerRadius(25)
		.overlay {
			Text(deck.localisedName ?? deck.wrappedName)
				.font(.largeTitle.bold())
				.foregroundColor(.white)
				.shadow(color: .black.opacity(0.5), radius: 5)
		}
		.navigationButtons(alignment: .topTrailing, padding: 16) {
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
