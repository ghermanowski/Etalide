//
//  DeckPopupView.swift
//  Etalide
//
//  Created by Gregor Hermanowski on 10. June.
//

import SwiftUI

struct DeckPopupView: View {
	init(isPresented: Binding<Bool>) {
		_isPresented = isPresented
	}
	
	@Environment(\.managedObjectContext) private var moc
	
	@Binding private var isPresented: Bool
	
	@State private var deckName = ""
	
    var body: some View {
		VStack(spacing: 32) {
			TextField("Name", text: $deckName)
				.font(.system(.largeTitle).weight(.bold))
				.multilineTextAlignment(.center)
				.foregroundStyle(Color.accentColor)
				.fixedSize()
		}
		.padding(.top, 96)
		.padding(.horizontal, 48)
		.padding(.bottom, 32)
		.frame(minWidth: UIScreen.main.bounds.width / 2)
		.background(Color.white)
		.cornerRadius(25)
		.navigationButtons(alignment: .topLeading, padding: 24) {
			Button(action: dismiss) {
				Image(systemName: "xmark")
			}
			.buttonStyle(.circle)
		}
		.navigationButtons(alignment: .top, padding: 24) {
			Text("New Deck")
				.font(.largeTitle.weight(.bold))
		}
		.navigationButtons(alignment: .topTrailing, padding: 24) {
			Button(action: saveDeck) {
				Image(systemName: "checkmark")
			}
			.buttonStyle(.circle)
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(Color.primary.opacity(0.75))
    }
	
	private func dismiss() {
		isPresented = false
	}
	
	private func saveDeck() {
		_ = Deck(context: moc, name: deckName)
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
