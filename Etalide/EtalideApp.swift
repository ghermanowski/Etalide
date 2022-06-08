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
	
	@State private var isLandscape = true
	
    var body: some Scene {
        WindowGroup {
           ContentView()
				.environment(\.managedObjectContext, dataController.container.viewContext)
				.environment(\.isLandscape, isLandscape)
				.onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
					guard let scene = UIApplication.shared.connectedScenes
						.first(where: { $0.activationState == .foregroundActive && $0 is UIWindowScene })
							as? UIWindowScene else {
						return
					}
					
					isLandscape = scene.interfaceOrientation.isLandscape
				}
        }
    }
}
