//
//  CircleStyle.swift
//  Etalide
//
//  Created by Gregor Hermanowski on 08/06/22.
//

import SwiftUI

struct CircleStyle: ButtonStyle {
	let invertColours: Bool
	
	func makeBody(configuration: Configuration) -> some View {
		let tintColour = configuration.role == .destructive ? Color.red : .accentColor
		
		configuration.label
			.symbolVariant(.circle.fill)
			.symbolRenderingMode(.palette)
			.foregroundStyle(
				invertColours ? tintColour : .white,
				invertColours ? .white : tintColour
			)
			.font(.system(.largeTitle).weight(.semibold))
			.scaleEffect(configuration.isPressed ? 0.85 : 1)
			.opacity(configuration.isPressed ? 0.75 : 1)
	}
}

extension ButtonStyle where Self == CircleStyle {
	static var circle: CircleStyle {
		circle()
	}
	
	static func circle(invertColours: Bool = false) -> CircleStyle {
		CircleStyle(invertColours: invertColours)
	}
}
