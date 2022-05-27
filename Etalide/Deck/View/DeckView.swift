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
				let columns = Array(repeating: GridItem(.flexible()), count: 3)
				
				LazyVGrid(columns: columns, spacing: 20) {
					CardView(in: deck)
					
					if let cards = deck.allCards {
						ForEach(cards) { card in
							CardView(card, in: deck)
						}
					}
				}
				.padding()
			}
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					EditButton()
				}
			}
			.navigationTitle(deck.wrappedName)
			.navigationBarTitleDisplayMode(.inline)
		}
	}
}

struct DeckView_Previews: PreviewProvider {
    static var previews: some View {
        DeckView(Deck())
    }
}
