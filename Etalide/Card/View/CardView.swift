//
//  CardView.swift
//  Etalide
//
//  Created by Gregor Hermanowski on 26/05/22.
//

import SwiftUI

struct CardView: View {
	init(_ card: Card? = nil, in deck: Deck? = nil) {
		self.card = card
		self.deck = deck
		
		_cardName = .init(initialValue: card?.name ?? "")
	}
	
	@Environment(\.editMode) private var editMode
	@Environment(\.managedObjectContext) private var moc
	@Environment(\.scenePhase) private var scenePhase
	
	private let card: Card?
	private let deck: Deck?
	
	@State private var cardName: String
	@State private var image: UIImage?
	@State private var showImagePicker = false
	
    var body: some View {
		ZStack(alignment: .bottom) {
			
			Button {
				showImagePicker.toggle()
			} label: {
				Group {
					if let image = image {
						Image(uiImage: image)
							.resizable()
					} else if let imageURL = card?.imageURL {
						CardImageView(imageURL)
					} else {
						Label("Choose image", systemImage: "camera.fill")
							.labelStyle(.iconOnly)
							.font(.largeTitle)
							.offset(y: -20)
					}
				}
				.frame(minWidth: 75, maxWidth: .infinity, minHeight: 100)
				.background(Color.gray.opacity(0.5))
			}
			
			// TODO: Change image of presets
			
			if !cardName.isEmpty || editMode?.wrappedValue == .active {
				TextField("Name", text: $cardName)
					.font(.largeTitle.weight(.bold))
					.foregroundColor(.white)
					.multilineTextAlignment(.center)
					.frame(maxWidth: .infinity)
					.padding(.vertical)
					.background(.ultraThinMaterial)
					.onSubmit {
						if image != nil {
							editMode?.wrappedValue = .inactive
						}
					}
			}
		}
		.frame(minWidth: 75, minHeight: 100)
		.aspectRatio(3 / 4, contentMode: .fit)
		.cornerRadius(20)
		.overlay(alignment: .topTrailing) {
			if editMode?.wrappedValue == .active,
			   let card = card {
				Button(role: .destructive) {
					deleteCard(card: card)
				} label: {
					Label("Delete", systemImage: "trash.fill")
						.labelStyle(.iconOnly)
						.padding()
				}
			}
		}
		.disabled(editMode?.wrappedValue != .active)
		.sheet(isPresented: $showImagePicker) {
			ImagePicker(image: $image)
		}
		.onChange(of: editMode?.wrappedValue) { editMode in
			if scenePhase == .active,
			   let editMode = editMode,
			   editMode == .inactive {
				saveCard()
			}
		}
	}
	
	private func deleteCard(card: Card) {
		moc.delete(card)
		saveContext()
		
		// Preset assets could also be deleted via Card.imageURL.
		// This is not done because then the presets cannot be restored.
		if card.assetName == nil {
			ImageManager.shared.delete(withName: card.id!.uuidString)
		}
	}
	
	private func saveContext() {
		do {
			try moc.save()
		} catch {
			fatalError(error.localizedDescription)
		}
	}
	
	/// Saves changes to an existing card or creates a new card.
	private func saveCard() {
		// When no image was selected, a new name for the existing card will be saved if it was modified.
		guard let image = image else {
			guard let card = card,
				  card.name != cardName else {
				return
			}
			
			card.name = cardName
			saveContext()
			return
		}
		
		guard let imageData = image.jpegData(compressionQuality: 1) else {
			print("Could not get image data.")
			return
		}
		
		guard let card = card else {
			// If a new card should be created, it needs to have a deck,
			// because currently there is no way to manage cards without decks from the UI.
			guard let deck = deck else {
				print("No deck present.")
				return
			}
			
			let newCard = Card(context: moc, name: cardName)
			newCard.addToDeck(deck)
			saveContext()
			
			ImageManager.shared.save(imageData, withName: newCard.id!.uuidString)
			return
		}
		
		card.name = cardName
		// If the card was part of a preset, the assetName needs to be deleted,
		// so that the new image will be used.
		card.assetName = nil
		saveContext()
		
		ImageManager.shared.save(imageData, withName: card.id!.uuidString)
	}
}

struct CardView_Previews: PreviewProvider {
	static var previews: some View {
		CardView(Card())
	}
}
