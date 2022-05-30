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
					if let assetName = card?.assetName {
						Image(assetName)
							.resizable()
					} else if let imageURL = card?.imageURL {
						AsyncImage(url: imageURL) { image in
							image
								.resizable()
						} placeholder: {
							ProgressView()
						}
					} else if let image = image {
						Image(uiImage: image)
							.resizable()
					} else {
						Label("Choose image", systemImage: "camera.fill")
							.labelStyle(.iconOnly)
							.font(.largeTitle)
							.offset(y: -20)
					}
				}
				.frame(minWidth: 225, maxWidth: .infinity, minHeight: 300)
				.background(Color.gray.opacity(0.5))
			}
			
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
		.frame(minWidth: 225, minHeight: 300)
		.aspectRatio(3 / 4, contentMode: .fit)
		.cornerRadius(20)
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
	
	private func saveContext() {
		do {
			try moc.save()
		} catch {
			fatalError(error.localizedDescription)
		}
	}
	
	private func saveCard() {
		guard let image = image else {
			guard card == nil else {
				if card?.name != cardName {
					card?.name = cardName
					saveContext()
				}
				
				return
			}
			
			print("No image selected.")
			return
		}
		
		guard let imageData = image.jpegData(compressionQuality: 1) else {
			print("Could not get image data.")
			return
		}
		
		guard card == nil else {
			card?.name = cardName
			
			if card?.image != image {
				ImageManager.shared.save(imageData, withName: card!.id!.uuidString)
			}
			
			return
		}
		
		guard let deck = deck else {
			print("No deck present.")
			return
		}
		
		let newCard = Card(context: moc, name: cardName)
		newCard.addToDeck(deck)
		saveContext()
		
		ImageManager.shared.save(imageData, withName: newCard.id!.uuidString)
	}
}

struct CardView_Previews: PreviewProvider {
	static var previews: some View {
		CardView(Card())
	}
}
