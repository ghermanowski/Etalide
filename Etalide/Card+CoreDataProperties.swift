//
//  Card+CoreDataProperties.swift
//  Etalide
//
//  Created by Alessia Andrisani on 24/05/22.
//
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var deck: NSSet?
	
	var wrappedName: String {
		name ?? "No name"
	}
	
	var wrappedID: UUID {
		id ?? UUID()
	}

}

// MARK: Generated accessors for deck
extension Card {

    @objc(addDeckObject:)
    @NSManaged public func addToDeck(_ value: Deck)

    @objc(removeDeckObject:)
    @NSManaged public func removeFromDeck(_ value: Deck)

    @objc(addDeck:)
    @NSManaged public func addToDeck(_ values: NSSet)

    @objc(removeDeck:)
    @NSManaged public func removeFromDeck(_ values: NSSet)

}

extension Card : Identifiable {

}
