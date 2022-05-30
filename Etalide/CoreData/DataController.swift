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
			
			[
				"Cat",
				"Dog",
			]
				.forEach { animal in
					let card = Card(context: context, name: animal, assetName: animal)
					card.addToDeck(animalsDeck)
				}
			
			do {
				try context.save()
				hasBeenLaunched = true
			} catch {
				print("Could not save preset decks: \(error.localizedDescription)")
			}
		}
	}
}
