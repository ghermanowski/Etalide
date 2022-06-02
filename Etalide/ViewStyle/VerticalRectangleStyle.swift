//
//  VerticalRectangleStyle.swift
//  Etalide
//
//  Created by Gregor Hermanowski on 27/05/22.
//

import SwiftUI

struct VerticalRectangleStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		(configuration.isPressed ? Color.accentColor : Color(uiColor: .secondarySystemBackground))
			.aspectRatio(3 / 4, contentMode: .fit)
			.cornerRadius(25)
			.overlay { configuration.label }
	}
}

extension ButtonStyle where Self == VerticalRectangleStyle {
	static var verticalRectangle: VerticalRectangleStyle {
		VerticalRectangleStyle()
	}
}
