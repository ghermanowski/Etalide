//
//  CircleStyle.swift
//  Etalide
//
//  Created by Gregor Hermanowski on 08/06/22.
//

import SwiftUI

struct CircleStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.foregroundColor(configuration.role == .destructive ? .red : .backgroundBlue)
			.font(.system(.largeTitle).weight(.semibold))
			.scaleEffect(configuration.isPressed ? 0.85 : 1)
	}
}

extension ButtonStyle where Self == CircleStyle {
	static var circle: CircleStyle {
		CircleStyle()
	}
}
