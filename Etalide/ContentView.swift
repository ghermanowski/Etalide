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
			DeckGridView()
		}
		.navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
