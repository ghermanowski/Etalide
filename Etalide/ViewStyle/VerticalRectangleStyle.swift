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
			.scaleEffect(configuration.isPressed ? 0.95 : 1)
	}
}

extension ButtonStyle where Self == VerticalRectangleStyle {
	static var verticalRectangle: VerticalRectangleStyle {
		VerticalRectangleStyle()
	}
}
