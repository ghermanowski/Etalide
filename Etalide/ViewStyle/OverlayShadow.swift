//
//  OverlayShadow.swift
//  Etalide
//
//  Created by Gregor Hermanowski on 13/06/22.
//

import SwiftUI

struct OverlayShadow: ViewModifier {
	@Binding var isShown: Bool
	
	func body(content: Content) -> some View {
		content
			.overlay {
				if isShown {
					Color.black.opacity(0.75)
						.frame(maxWidth: .infinity, maxHeight: .infinity)
						.ignoresSafeArea(.all)
				}
			}
	}
}

extension View {
	func overlayShadow(isShown: Binding<Bool>) -> some View {
		modifier(OverlayShadow(isShown: isShown))
	}
}
