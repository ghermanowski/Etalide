//
//  DeckPopoverView.swift
//  Etalide
//
//  Created by Galina Aleksandrova on 26/05/22.
//

import SwiftUI

struct DeckPopoverView: View {
    var body: some View {
        VStack {
        Text("Animals")
            .font(.system(.largeTitle))
            
            HStack {
                // Card preview view
                VStack {
                    
                }
                
                // Buttons view
                VStack {
                    
                    NavigationLink {
                        // navigate to memory game view
                    } label: {
                        ButtonView(title: "Play Memory")
                    }
                    
                    NavigationLink {
                        // navigate to flashcard game
                    } label: {
                        ButtonView(title: "Play FlashCards")
                    }
                    
                }
            }
        }
    }
}

struct DeckPopoverView_Previews: PreviewProvider {
    static var previews: some View {
        DeckPopoverView()
            .previewLayout(.sizeThatFits)
    }
}
