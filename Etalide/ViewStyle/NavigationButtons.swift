//
//  NavigationButtons.swift
//  Etalide
//
//  Created by Gregor Hermanowski on 08/06/22.
//

import SwiftUI

extension View {
	func navigationButtons(
		alignment: Alignment = .topTrailing,
		buttons: @escaping () -> some View
	) -> some View {
		overlay(alignment: alignment) {
			HStack(spacing: 20) {
				buttons()
			}
			.padding([.top, .horizontal], 32)
		}
	}
}
