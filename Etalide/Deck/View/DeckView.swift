//
//  DeckView.swift
//  Etalide
//
//  Created by Gregor Hermanowski on 26/05/22.
//

import SwiftUI

struct DeckView: View {
    var body: some View {
		NavigationView {
			ScrollView {
				let columns = Array(repeating: GridItem(.flexible()), count: 4)
				
				LazyVGrid(columns: columns, spacing: 20) {
					CardView()
				}
				.padding(.horizontal)
				.toolbar {
					ToolbarItem(placement: .navigationBarTrailing) {
						EditButton()
					}
				}
			}
		}
	}
}

struct DeckView_Previews: PreviewProvider {
    static var previews: some View {
        DeckView()
    }
}
