//
//  NavigationTitle.swift
//  Etalide
//
//  Created by Gregor Hermanowski on 09/06/22.
//

import SwiftUI

struct NavigationTitle: View {
	init(_ title: String, invertColours: Bool = false) {
		self.title = title
		self.invertColours = invertColours
	}
	
	@Environment(\.colorScheme) private var colourScheme
	
	private let title: String
	private let invertColours: Bool
	
    var body: some View {
		Text(title)
			.font(.largeTitle.weight(.bold))
			.foregroundColor(invertColours ? colourScheme == .dark ? .white : .background : .accentColor)
			.padding(.vertical)
			.frame(maxWidth: .infinity)
			.background(invertColours ? Color.accentColor : .background)
    }
}

struct NavigationTitle_Previews: PreviewProvider {
    static var previews: some View {
        NavigationTitle("Capito")
    }
}
