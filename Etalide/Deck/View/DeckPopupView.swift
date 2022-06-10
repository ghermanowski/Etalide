//
//  DeckPopupView.swift
//  Etalide
//
//  Created by Gregor Hermanowski on 10/06/22.
//

import SwiftUI

struct DeckPopupView: View {
	init(deck: Deck? = nil, isPresented: Binding<Bool>) {
		_isPresented = isPresented
		_deckName = State(initialValue: deck?.name ?? "")
		
		self.deck = deck
	}
	
	@Environment(\.managedObjectContext) private var moc
	
	private var deck: Deck?
	
	@Binding private var isPresented: Bool
	
	@State private var deckName: String
	
    var body: some View {
		VStack(spacing: 32) {
			TextField("Name", text: $deckName)
				.font(.system(.largeTitle).weight(.semibold))
				.multilineTextAlignment(.center)
				.foregroundStyle(Color.accentColor)
				.padding(.vertical)
				.frame(maxWidth: .infinity)
				.background(.regularMaterial)
				.cornerRadius(25)
		}
		.padding(.top, 96)
		.padding(.horizontal, 48)
		.padding(.bottom, 32)
		.frame(width: UIScreen.main.bounds.width / 2.75)
		.background(Color.background2)
		.cornerRadius(25)
		.navigationButtons(alignment: .topLeading, padding: 24) {
			Button(action: dismiss) {
				Image(systemName: "xmark")
			}
			.buttonStyle(.circle)
		}
		.navigationButtons(alignment: .top, padding: 24) {
			Text(deck == nil ? "New Deck" : "Edit")
				.font(.largeTitle.weight(.bold))
		}
		.navigationButtons(alignment: .topTrailing, padding: 24) {
			Button(action: saveDeck) {
				Image(systemName: "checkmark")
			}
			.buttonStyle(.circle)
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(Color.black.opacity(0.75))
    }
	
	private func dismiss() {
		isPresented = false
	}
	
	private func saveDeck() {
		guard let deck = deck else {
			_ = Deck(context: moc, name: deckName)
			saveContext()
			dismiss()
			return
		}
		
		deck.name = deckName
		saveContext()
		dismiss()
	}
	
	private func saveContext() {
		do {
			try moc.save()
		} catch {
			// TODO: Error handling
			fatalError(error.localizedDescription)
		}
	}
}

struct DeckPopupView_Previews: PreviewProvider {
    static var previews: some View {
		DeckPopupView(isPresented: .constant(true))
    }
}
