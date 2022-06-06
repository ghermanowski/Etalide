//
//  EtalideApp.swift
//  Etalide
//
//  Created by Gregor Hermanowski on 24/05/22.
//

import SwiftUI

@main
struct EtalideApp: App {
	@StateObject private var dataController = DataController()
	
    var body: some Scene {
        WindowGroup {
           ContentView()
				.environment(\.managedObjectContext, dataController.container.viewContext)
				.environmentObject(OrientationManager())
        }
    }
}
