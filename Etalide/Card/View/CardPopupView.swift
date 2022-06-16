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
		
		if let name = card?.name {
			_cardName = State(initialValue: name)
		} else {
			_cardName = .init(initialValue: card?.name ?? "")
		}
	}
	
	@Environment(\.isLandscape) private var isLandscape
	@Environment(\.managedObjectContext) private var moc
	
	private let card: Card?
	private let deck: Deck
	
	@Binding private var showPopover: Bool
	
	@State private var cardName: String
	@State private var image: UIImage?
	@State private var showImagePicker = false
	@State private var isDeletionRequested = false
	
	var body: some View {
		VStack(spacing: 32) {
			TextField("Name", text: $cardName)
				.font(.system(.largeTitle).weight(.semibold))
				.multilineTextAlignment(.center)
				.foregroundStyle(Color.accentColor)
				.padding(.vertical)
				.frame(maxWidth: .infinity)
				.background(Color.background)
				.cornerRadius(25)
			
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
			.buttonStyle(.scalesOnPress)
			.sheet(isPresented: $showImagePicker) {
				ImagePicker(image: $image)
			}
		}
		.padding(.top, 96)
		.padding(.horizontal, 48)
		.padding(.bottom, 32)
		.frame(maxWidth: UIScreen.main.bounds.width / (isLandscape ? 2 : 1.5))
		.background(Color.background2)
		.cornerRadius(25)
		.navigationButtons(alignment: .topLeading, padding: 24) {
			Button(action: dismiss) {
				Image(systemName: "xmark")
			}
			.buttonStyle(.circle)
		}
		.navigationButtons(alignment: .top, padding: 24) {
			Text(card == nil ? "New Card" : "Edit")
				.font(.largeTitle.weight(.bold))
				.foregroundColor(.accentColor)
		}
		.navigationButtons(alignment: .topTrailing, padding: 24) {
			if card != nil {
				Button(role: .destructive, action: requestDeletion) {
					Image(systemName: "trash")
				}
				.buttonStyle(.circle)
				.confirmationDialog(
					"Are you sure you want to delete this card?",
					isPresented: $isDeletionRequested,
					titleVisibility: .visible
				) {
					Button("Delete", role: .destructive, action: deleteCard)
				}
			}
			
			Button(action: saveCard) {
				Image(systemName: "checkmark")
			}
			.buttonStyle(.circle)
		}
		.transition(.overlay)
	}
	
	private func dismiss() {
		withAnimation {
			showPopover.toggle()
		}
	}
	
	private func requestDeletion() {
		isDeletionRequested = true
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
				dismiss()
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
