//
//  DeckOfCardsView.swift
//  Etalide
//
//  Created by Galina Aleksandrova on 26/05/22.
//

import SwiftUI

struct DeckOfCardsView: View {
    
    let gridItemLayot = Array(repeating: GridItem(.flexible(maximum: UIScreen.main.bounds.height / 5)), count: 4)
    
    var body: some View {
        
        LazyVGrid (columns: gridItemLayot) {
            ForEach(0..<12) { number in
                ZStack {
                    Color
                        .purple
                    Text("\(number)")
                }
                .aspectRatio(2/3, contentMode: .fit)
                .padding()
            }
        }
    }
}

struct DeckOfCardsView_Previews: PreviewProvider {
    static var previews: some View {
        DeckOfCardsView()
    }
}
