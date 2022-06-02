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
	
	@FetchRequest var decks: FetchedResults<Deck>
	
    var body: some View {
		let deck = decks.first!
		
		NavigationView {
			ScrollView {
				let columns = Array(repeating: GridItem(.flexible()), count: 5)
				
				LazyVGrid(columns: columns, spacing: 20) {
					NewCards(in: deck)
					
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
		.navigationViewStyle(.stack)
	}
}

private struct NewCards: View {
	init(in deck: Deck) {
		self.deck = deck
	}
	
	@State private var newCardsCount = 0
	
	private let deck: Deck
	
	var body: some View {
		Button {
			withAnimation {
				newCardsCount += 1
			}
		} label: {
			Label("New Card", systemImage: "plus.rectangle.portrait.fill")
		}
		.buttonStyle(.verticalRectangle)
		
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
