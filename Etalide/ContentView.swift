//
//  ContentView.swift
//  DecksView
//
//  Created by Diego Castro on 24/05/22.
//

import SwiftUI


let customColorNavAppearance = UINavigationBarAppearance()
struct ContentView: View {
    init() {
          customColorNavAppearance.configureWithOpaqueBackground()
          customColorNavAppearance.backgroundColor = UIColor(red: 0.094, green: 0.149, blue: 0.259, alpha: 1)
          customColorNavAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
          customColorNavAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
                 
          UINavigationBar.appearance().standardAppearance = customColorNavAppearance
          UINavigationBar.appearance().scrollEdgeAppearance = customColorNavAppearance
      }
    
    var body: some View {
        NavigationView {
        DeckGridView()
                .navigationBarTitle("Choose a Deck")
                .background(NavigationConfigurator { newColor in
                         newColor.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
                     })
    }
        .accentColor(.white)
    .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
