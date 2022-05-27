//
//  Deck+CoreDataClass.swift
//  Etalide
//
//  Created by Alessia Andrisani on 24/05/22.
//
//

import Foundation
import CoreData

@objc(Deck)
public class Deck: NSManagedObject {
	convenience init(context moc: NSManagedObjectContext,
					 id: UUID = UUID(),
					 name: String) {
		self.init(context: moc)
		self.id = id
		self.name = name
	}
}
