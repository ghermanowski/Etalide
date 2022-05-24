//
//  DataController.swift
//  Etalide
//
//  Created by Alessia Andrisani on 24/05/22.
//

import CoreData
import Foundation

class DataController: ObservableObject {
	let container = NSPersistentContainer(name: "Etalide")
	
	init() {
		container.loadPersistentStores { description, error in
			if let error = error {
				print("Etalide failed to load: \(error.localizedDescription)")
				return
			}
		}
	}
}
