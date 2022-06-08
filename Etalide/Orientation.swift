//
//  Orientation.swift
//  Etalide
//
//  Created by Gregor Hermanowski on 6. June.
//

import SwiftUI

private struct Orientation: EnvironmentKey {
	static let defaultValue: Bool = false
}

extension EnvironmentValues {
	var isLandscape: Bool {
		get { self[Orientation.self] }
		set { self[Orientation.self] = newValue }
	}
}