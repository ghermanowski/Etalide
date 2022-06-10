//
//  Decks.swift
//  Etalide
//
//  Created by Diego Castro on 25/05/22.
//

import SwiftUI

struct Decks: View {
	@Environment(\.isLandscape) private var isLandscape
	
	@State private var selectedDeck: Deck?
	@State private var showNewDeckView = false
    
	@FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) private var decks: FetchedResults<Deck>
    
	var body: some View {
		VStack(spacing: .zero) {
			NavigationTitle(String(localized: "Decks"), invertColours: true)
			
			ScrollView {
				let padding: CGFloat = isLandscape ? 40 : 30
				let columns = Array(
					repeating: GridItem(spacing: padding),
					count: isLandscape ? 4 : 3
				)
				
				LazyVGrid(columns: columns, spacing: padding) {
					ForEach(decks) { deck in
						Button {
							selectedDeck = deck
						} label: {
							DeckPreview(deck)
						}
						.buttonStyle(.verticalRectangle)
					}
				}
				.padding(padding)
			}
		}
        
		.navigationBarHidden(true)
		.background(Color.background)
		.navigationButtons(alignment: .topTrailing, padding: 16) {
			Button {
				showNewDeckView = true
			} label: {
				Image(systemName: "plus")
			}
			.buttonStyle(.circle(invertColours: true))
			.padding(.trailing, 8)
		}
		.overlay {
			if showNewDeckView {
				DeckPopupView(isPresented: $showNewDeckView)
			} else if let selectedDeck = selectedDeck {
				DeckPopoverView(
					selectedDeck,
					isShowingPopover: Binding(get: { self.selectedDeck != nil },
											  set: { self.selectedDeck = $0 ? selectedDeck : nil }))
			}
		}
	}
}

struct DeckGridView_Previews: PreviewProvider {
    static var previews: some View {
        Decks()
    }
}
