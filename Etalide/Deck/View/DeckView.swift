//
//  DeckView.swift
//  Etalide
//
//  Created by Gregor Hermanowski on 26/05/22.
//

import SwiftUI

struct DeckView: View {
	init(_ deck: Deck) {
		_decks = FetchRequest(
			entity: Deck.entity(),
			sortDescriptors: [],
			predicate: NSPredicate(format: "id = %@", deck.id! as CVarArg),
			animation: .default
		)
	}
	@State private var showEditCardPopover = false
	@FetchRequest var decks: FetchedResults<Deck>
	
	var body: some View {
		let deck = decks.first!
		
		ScrollView {
			let columns = Array(repeating: GridItem(.flexible()), count: 5)
			
			LazyVGrid(columns: columns, spacing: 20) {
                NewCards(in: deck, showEditCardPopover: $showEditCardPopover)
				
				if let cards = deck.allCards {
					ForEach(cards.sorted()) { card in
						CardView(card, in: deck)
					}
				}
			}
			.padding()
		}
		.toolbar {
			ToolbarItem(placement: .primaryAction) {
				EditButton()
			}
		}
		.navigationTitle(deck.wrappedName)
		.navigationBarTitleDisplayMode(.inline)
	}
}

private struct NewCards: View {
    init(in deck: Deck, showEditCardPopover: Binding<Bool>) {
        _showEditCardPopover = showEditCardPopover
		self.deck = deck
	}
	
	@State private var newCardsCount = 0
    @Binding var showEditCardPopover: Bool
	
	private let deck: Deck
	
	var body: some View {
		Button {
            showEditCardPopover = true
			withAnimation {
				newCardsCount += 1
			}
		} label: {
			Label("New Card", systemImage: "plus.rectangle.portrait.fill")
		}
		.buttonStyle(.scalesOnPress)
        
		ForEach(0..<newCardsCount, id: \.self) { _ in
			CardView(in: deck)
		}
	}
}

struct DeckView_Previews: PreviewProvider {
	static var previews: some View {
		DeckView(Deck())
	}
}
