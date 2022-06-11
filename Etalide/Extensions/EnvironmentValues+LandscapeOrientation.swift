//
//  LandscapeOrientation.swift
//  Etalide
//
//  Created by Gregor Hermanowski on 06/06/22.
//

import SwiftUI

private struct LandscapeOrientation: EnvironmentKey {
	static let defaultValue: Bool = false
}

extension EnvironmentValues {
	var isLandscape: Bool {
		get { self[LandscapeOrientation.self] }
		set { self[LandscapeOrientation.self] = newValue }
	}
}
