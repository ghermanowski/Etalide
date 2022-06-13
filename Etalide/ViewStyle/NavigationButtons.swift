//
//  NavigationButtons.swift
//  Etalide
//
//  Created by Gregor Hermanowski on 08/06/22.
//

import SwiftUI

extension View {
	func navigationButtons<Buttons: View>(
		alignment: Alignment = .topTrailing,
		padding: CGFloat = 32,
		@ViewBuilder buttons: () -> Buttons
	) -> some View {
		overlay(alignment: alignment) {
			HStack(spacing: 20) {
				buttons()
			}
			.padding(padding)
		}
	}
}
