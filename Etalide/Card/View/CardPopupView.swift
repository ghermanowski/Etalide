//
//  CardPopupView.swift
//  Etalide
//
//  Created by Galina Aleksandrova on 09/06/22.
//

import SwiftUI

struct CardPopupView: View {
	init(_ card: Card? = nil, deck: Deck, showPopover: Binding<Bool>) {
		self.card = card
		self.deck = deck
		
		_showPopover = showPopover
		
		if let assetName = card?.assetName,
		   let name = card?.name,
		   name == assetName {
			let localisedName = String(localized: String.LocalizationValue(name))
			_cardName = State(initialValue: localisedName)
		} else {
			_cardName = .init(initialValue: card?.name ?? "")
		}
	}
	
	@Environment(\.managedObjectContext) private var moc
	
	private let card: Card?
	private let deck: Deck
	
	@Binding private var showPopover: Bool
	
	@State private var cardName: String
	@State private var image: UIImage?
	@State private var showImagePicker = false
	
	var body: some View {
		VStack(spacing: 32) {
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
						Color.accentColor
					}
				}
				.aspectRatio(3 / 4, contentMode: .fit)
				.cornerRadius(25)
				.overlay {
					Label("Choose image", systemImage: "camera.circle.fill")
						.labelStyle(.iconOnly)
						.symbolVariant(.circle.fill)
						.symbolRenderingMode(.palette)
						.imageScale(.large)
						.foregroundStyle(Color.white, Color.accentColor)
						.font(.system(.largeTitle).weight(.semibold))
				}
			}
			.buttonStyle(.verticalRectangle)
			.frame(width: UIScreen.main.bounds.width / 4)
			
			TextField("Name", text: $cardName)
				.font(.system(.largeTitle).weight(.bold))
				.multilineTextAlignment(.center)
				.foregroundStyle(Color.accentColor)
				.fixedSize()
		}
		.padding(.top, 96)
		.padding(.horizontal, 48)
		.padding(.bottom, 32)
		.background(Color.white)
		.cornerRadius(25)
		.navigationButtons(alignment: .topLeading, padding: 24) {
			Button(action: dismiss) {
				Image(systemName: "chevron.down")
			}
			.buttonStyle(.circle)
		}
		.navigationButtons(alignment: .topTrailing, padding: 24) {
			if card != nil {
				Button(role: .destructive, action: deleteCard) {
					Image(systemName: "trash")
				}
				.buttonStyle(.circle)
			}
			
			Button(action: saveCard) {
				Image(systemName: "checkmark")
			}
			.buttonStyle(.circle)
		}
		.sheet(isPresented: $showImagePicker) {
			ImagePicker(image: $image)
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(Color.primary.opacity(0.75))
	}
	
	private func dismiss() {
		showPopover.toggle()
	}
	
	private func deleteCard() {
		guard let card = card else { return }
		
		let cardID = card.id?.uuidString
		let cardAssetName = card.assetName
		
		moc.delete(card)
		saveContext()
		
		// Preset assets could also be deleted via Card.imageURL.
		// This is not done because then the presets cannot be restored.
		if cardAssetName == nil,
		   let cardID = cardID {
			ImageManager.shared.delete(withName: cardID)
		}
		
		dismiss()
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
			dismiss()
			return
		}
		
		guard let imageData = image.jpegData(compressionQuality: 1) else {
			print("Could not get image data.")
			return
		}
		
		guard let card = card else {
			let newCard = Card(context: moc, name: cardName)
			newCard.addToDeck(deck)
			saveContext()
			
			ImageManager.shared.save(imageData, withName: newCard.id!.uuidString)
			dismiss()
			return
		}
		
		card.name = cardName
		// If the card was part of a preset, the assetName needs to be deleted,
		// so that the new image will be used.
		card.assetName = nil
		saveContext()
		
		ImageManager.shared.save(imageData, withName: card.id!.uuidString)
		
		dismiss()
	}
}

struct CardPopupView_Previews: PreviewProvider {
	static var previews: some View {
		CardPopupView(deck: Deck(), showPopover: .constant(true))
	}
}
