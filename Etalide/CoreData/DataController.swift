//
//  DataController.swift
//  Etalide
//
//  Created by Alessia Andrisani on 24/05/22.
//

import CoreData
import Foundation
import SwiftUI

class DataController: ObservableObject {
	@AppStorage("hasBeenLaunched") private var hasBeenLaunched = false
	
	let container = NSPersistentContainer(name: "Etalide")
	
	init() {
		container.loadPersistentStores { description, error in
			if let error = error {
				print("Etalide failed to load: \(error.localizedDescription)")
				return
			}
		}
		
		if !hasBeenLaunched {
			let context = container.viewContext
			let animalsDeck = Deck(context: context, name: "Animals")
			
			func createCard(_ name: String, in deck: Deck) {
				let card = Card(context: context, name: name, assetName: name)
				card.addToDeck(deck)
			}
			
			[
				"Bear",
				"Cat",
				"Cow",
				"Dog",
				"Hen",
				"Horse",
				"Lion",
				"Parrot",
				"Pig",
				"Rabbit",
				"Sheep",
				"Tiger",
			]
				.forEach { createCard($0, in: animalsDeck) }
			
			let foodDeck = Deck(context: context, name: "Food")
			
			[
				"Cake",
				"Caprese",
				"Cheese",
				"French Fries",
				"Ice Cream",
				"Mokka",
				"Orange",
				"Pasta",
				"Pizza",
				"Salami",
				"Strawberry",
				"Wine",
			]
				.forEach { createCard($0, in: foodDeck) }
			
			do {
				try context.save()
				hasBeenLaunched = true
			} catch {
				print("Could not save preset decks: \(error.localizedDescription)")
			}
		}
	}
}
