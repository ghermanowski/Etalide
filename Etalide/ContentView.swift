//
//  ContentView.swift
//  Etalide
//
//  Created by Diego Castro on 24/05/22.
//

import SwiftUI

struct ContentView: View {
	var body: some View {
		NavigationView {
			Decks()
		}
		.navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
