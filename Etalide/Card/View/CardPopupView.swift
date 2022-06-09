//
//  CardPopupView.swift
//  Etalide
//
//  Created by Galina Aleksandrova on 09/06/22.
//

import SwiftUI

struct CardPopupView: View {
    init(_ card: Card? = nil, in deck: Deck? = nil, showPopover: Binding<Bool>) {
        self.card = card
        self.deck = deck
        self._showPopover = showPopover
        
        let assetName = card?.assetName != nil ? String(localized: String.LocalizationValue(card!.assetName!)) : nil
        _cardName = .init(initialValue: assetName ?? card?.name ?? "")
    }
    
    @Environment(\.managedObjectContext) private var moc
    
    private let card: Card?
    private let deck: Deck?
    
    @Binding var showPopover: Bool
    @State private var cardName: String
    @State private var image: UIImage?
    @State private var showImagePicker = false
    
    var body: some View {
        Button {
            showImagePicker.toggle()
        } label: {
            Group {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                } else if let imageURL = card?.imageURL {
                    CardImageView(imageURL)
                }
            }
            .overlay {
                    Label("Choose image", systemImage: "camera.fill")
                        .labelStyle(.iconOnly)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .offset(y: -20)
                
            }
        }
        .buttonStyle(.verticalRectangle)
        .overlay(alignment: .bottom) {
                TextField("Name", text: $cardName)
                    .font(Font.system(.largeTitle, design: .serif).weight(.bold))
                    .foregroundStyle(.regularMaterial)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                    .background(Color.backgroundBlue)
            
        }
        .cornerRadius(25)
        .overlay(alignment: .topTrailing) {
            if let card = card {
                Button(role: .destructive) {
                    deleteCard(card: card)
                } label: {
                    Label("Delete", systemImage: "trash.fill")
                        .labelStyle(.iconOnly)
                        .padding()
                }
            }
        }
        .overlay(alignment: .topTrailing, content: {
            Button {
                showPopover = false
                // MARK: need to improve card saving - GREGOR
                saveCard()
                saveContext()
            } label: {
                Image(systemName: "checkmark.circle.fill")
            }
            .buttonStyle(.circle)
            .padding()
        })
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $image)
        }
    }
    
    private func deleteCard(card: Card) {
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

struct CardPopupView_Previews: PreviewProvider {
    static var previews: some View {
        CardPopupView(showPopover: .constant(true))
    }
}
