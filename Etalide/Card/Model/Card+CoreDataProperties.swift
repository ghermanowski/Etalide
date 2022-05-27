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
	
	@NSManaged public var name: String?
	@NSManaged public var id: UUID?
	@NSManaged public var decks: NSSet?
	
	var wrappedName: String {
		name ?? "No name"
	}
	
	var wrappedID: UUID {
		id ?? UUID()
	}
	
	var image: UIImage? {
		guard let id = id else { return nil }
		return ImageManager.shared.find(id.uuidString)
	}
	
	var imageURL: URL? {
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
