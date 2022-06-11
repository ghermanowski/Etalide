//
//  ScalesOnPressStyle.swift
//  Etalide
//
//  Created by Gregor Hermanowski on 27/05/22.
//

import SwiftUI

struct ScalesOnPressStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.scaleEffect(configuration.isPressed ? 0.95 : 1)
	}
}

extension ButtonStyle where Self == ScalesOnPressStyle {
	static var scalesOnPress: ScalesOnPressStyle {
		ScalesOnPressStyle()
	}
}
