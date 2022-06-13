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
			let fileManager = FileManager.default
			let folderURLs = Bundle.main.urls(forResourcesWithExtension: nil, subdirectory: "Images")!
			let decks = folderURLs
				.map(\.lastPathComponent)
				.map {
					Deck(
						context: context,
						name: String(localized: String.LocalizationValue($0)),
						assetName: $0
					)
				}
			
			for index in folderURLs.indices {
				do {
					let files = try fileManager.contentsOfDirectory(atPath: folderURLs[index].path)
					
					for file in files {
						let fileName = file.replacingOccurrences(of: ".jpeg", with: "")
						let cardName = String(localized: String.LocalizationValue(fileName))
						let card = Card(context: context, name: cardName, assetName: fileName)
						card.addToDeck(decks[index])
					}
				} catch {
					print(error.localizedDescription)
				}
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
