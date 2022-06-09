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
	
	private let title: String
	private let invertColours: Bool
	
    var body: some View {
		Text(title)
			.font(.largeTitle.weight(.bold))
			.foregroundColor(invertColours ? .background : .backgroundBlue)
			.padding(.vertical)
			.frame(maxWidth: .infinity)
			.background(invertColours ? Color.backgroundBlue : .background)
    }
}

struct NavigationTitle_Previews: PreviewProvider {
    static var previews: some View {
        NavigationTitle("Capito")
    }
}
