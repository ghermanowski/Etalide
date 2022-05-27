//
//  VerticalRectangleStyle.swift
//  Etalide
//
//  Created by Gregor Hermanowski on 27/05/22.
//

import SwiftUI

struct VerticalRectangleStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.frame(maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
			.background(configuration.isPressed ? Color.accentColor : Color(uiColor: .secondarySystemBackground))
			.cornerRadius(25)
	}
}

extension ButtonStyle where Self == VerticalRectangleStyle {
	static var verticalRectangle: VerticalRectangleStyle {
		VerticalRectangleStyle()
	}
}
