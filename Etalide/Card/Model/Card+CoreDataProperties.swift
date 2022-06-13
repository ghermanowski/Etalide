//
//  Card+CoreDataProperties.swift
//  Etalide
//
//  Created by Alessia Andrisani on 24/05/22.
//

import Foundation
import CoreData
import UIKit

extension Card {
	@nonobjc
	public class func fetchRequest() -> NSFetchRequest<Card> {
		NSFetchRequest<Card>(entityName: "Card")
	}
	
	@NSManaged public var id: UUID?
	@NSManaged public var name: String?
	/// Name of the asset image. Only has a value for cards of a preset.
	@NSManaged public var assetName: String?
	@NSManaged public var decks: NSSet?
	
	var imageURL: URL? {
		// Attempts to find a matching file from the images directory for preset cards.
		guard assetName == nil else {
			guard let decks = decks?.allObjects as? [Deck] else { return nil }
			
			for deck in decks {
				if let url = Bundle.main.url(
					forResource: assetName!,
					withExtension: "jpeg",
					subdirectory: "Images/" + deck.assetName!
				) {
					return url
				}
			}
			
			return nil
		}
		
		guard let id = id else { return nil }
		
		return ImageManager.shared.fileURL(for: id.uuidString)
	}
}

// MARK: Generated accessors for deck
extension Card {
	@objc(addDecksObject:)
	@NSManaged public func addToDeck(_ value: Deck)
	
	@objc(removeDecksObject:)
	@NSManaged public func removeFromDeck(_ value: Deck)
	
	@objc(addDecks:)
	@NSManaged public func addToDeck(_ values: NSSet)
	
	@objc(removeDecks:)
	@NSManaged public func removeFromDeck(_ values: NSSet)
}

extension Card: Identifiable {}

extension Card: Comparable {
	public static func < (lhs: Card, rhs: Card) -> Bool {
		guard let leftName = lhs.name else { return lhs.name == rhs.name }
		guard let rightName = rhs.name else { return true }
		return leftName.localizedStandardCompare(rightName) == .orderedAscending
	}
}
