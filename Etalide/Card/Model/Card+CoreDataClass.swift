//
//  Card+CoreDataClass.swift
//  Etalide
//
//  Created by Alessia Andrisani on 24/05/22.
//
//

import Foundation
import CoreData

@objc(Card)
public class Card: NSManagedObject {
	convenience init(context moc: NSManagedObjectContext,
					 id: UUID = UUID(),
					 name: String,
					 deck: Deck) {
		self.init(context: moc)
		self.id = id
		self.name = name
//		self.addToDeck(deck)
	}
}
