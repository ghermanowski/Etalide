//
//  Decks.swift
//  Etalide
//
//  Created by Diego Castro on 25/05/22.
//

import SwiftUI

struct Decks: View {
	@Environment(\.editMode) private var editMode
	@Environment(\.isLandscape) private var isLandscape
	@Environment(\.managedObjectContext) private var moc
	
	@State private var selectedDeck: Deck?
    
	@FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) private var decks: FetchedResults<Deck>
    
	var body: some View {
		VStack {
			Text("Decks")
				.font(.largeTitle.weight(.bold))
				.foregroundColor(.backgroundBlue)
				.padding(.vertical)
				.frame(maxWidth: .infinity)
				.background(Color.white)
				.navigationButtons(alignment: .topTrailing) {
					Button {
						_ = Deck(context: moc, name: "TestDeck")
						saveContext()
					} label: {
						Image(systemName: "plus")
					}
					.buttonStyle(.circle)
					
					Button {
						if editMode?.wrappedValue != .active {
							editMode?.wrappedValue = .active
						} else {
							editMode?.wrappedValue = .inactive
						}
					} label: {
						Image(systemName: "pencil")
					}
					.buttonStyle(.circle)
				}
			
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
				.environment(\.editMode, editMode)
				.padding([.horizontal, .bottom], padding)
			}
		}
		.navigationBarHidden(true)
		.overlay {
			if let selectedDeck = selectedDeck {
				DeckPopoverView(
					selectedDeck,
					isShowingPopover: Binding(get: { self.selectedDeck != nil },
											  set: { self.selectedDeck = $0 ? selectedDeck : nil }))
			}
		}
	}
	
	private func saveContext() {
		do {
			try moc.save()
		} catch {
			fatalError("Unresolved error: \(error.localizedDescription)")
		}
	}
}

struct DeckGridView_Previews: PreviewProvider {
    static var previews: some View {
        Decks()
    }
}
