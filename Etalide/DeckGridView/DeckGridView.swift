//
//  DeckGridView.swift
//  Etalide
//
//  Created by Diego Castro on 25/05/22.
//

import SwiftUI

struct DeckGridView: View {
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
				let columns = Array(
					repeating: GridItem(spacing: 20),
					count: isLandscape ? 4 : 3
				)
				
				LazyVGrid(columns: columns, spacing: 20) {
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
				.padding()
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
        DeckGridView()
    }
}
