//
//  DeckGridView.swift
//  Etalide
//
//  Created by Diego Castro on 25/05/22.
//

import SwiftUI

struct DeckGridView: View {
	@Environment(\.managedObjectContext) private var moc
	@Environment(\.isLandscape) private var isLandscape
	
	@State private var selectedDeck: Deck?
    
	@FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) private var decks: FetchedResults<Deck>
    
	var body: some View {
		ScrollView {
			let columns = Array(
				repeating: GridItem(spacing: 20),
				count: isLandscape ? 4 : 3
			)
			
			LazyVGrid(columns: columns, spacing: 20) {
				Button {
					_ = Deck(context: moc, name: "TestDeck")
					saveContext()
				} label: {
					VStack(spacing: 16) {
						Image(systemName: "plus")
							.font(.title.bold())
						
						Text("New Deck")
							.font(.title3.bold())
					}
					.foregroundColor(.blue)
				}
				.buttonStyle(.verticalRectangle)
				
				ForEach(decks) { deck in
					Button {
						selectedDeck = deck
					} label: {
						DeckPreview(deck)
					}
					.buttonStyle(.verticalRectangle)
				}
			}
			.padding()
		}
        .overlay {
            if let selectedDeck = selectedDeck {
                DeckPopoverView(
                    selectedDeck,
                    isShowingPopover: Binding(get: { self.selectedDeck != nil },
                                              set: { self.selectedDeck = $0 ? selectedDeck : nil }))
				.padding(.horizontal, 64)
				.padding(.vertical, 32)
				.background(Color(uiColor: .secondarySystemBackground))
            }
        }
		.navigationTitle("Decks")
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
