//
//  AnyTransition.swift
//  Etalide
//
//  Created by Gregor Hermanowski on 13/06/22.
//

import SwiftUI

extension AnyTransition {
	static let overlay = AnyTransition.opacity.combined(with: .move(edge: .bottom))
}
