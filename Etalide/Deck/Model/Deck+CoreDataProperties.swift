//
//  Deck+CoreDataProperties.swift
//  Etalide
//
//  Created by Alessia Andrisani on 24/05/22.
//
//

import Foundation
import CoreData


extension Deck {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Deck> {
        return NSFetchRequest<Deck>(entityName: "Deck")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
	@NSManaged public var assetName: String?
    @NSManaged public var cards: NSSet?

	var wrappedName: String {
		name ?? "No name"
	}
	
	var wrappedID: UUID {
		id ?? UUID()
	}
	
	var allCards: [Card]? {
		cards?.allObjects as? [Card]
	}
}

// MARK: Generated accessors for cards
extension Deck {

    @objc(addCardsObject:)
    @NSManaged public func addToCards(_ value: Card)

    @objc(removeCardsObject:)
    @NSManaged public func removeFromCards(_ value: Card)

    @objc(addCards:)
    @NSManaged public func addToCards(_ values: NSSet)

    @objc(removeCards:)
    @NSManaged public func removeFromCards(_ values: NSSet)

}

extension Deck : Identifiable {

}
