//
//  OrientationManager.swift
//  Etalide
//
//  Created by Gregor Hermanowski on 06/06/22.
//

import Combine
import Foundation
import UIKit

final class OrientationManager: ObservableObject {
	init() {
		NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
			.sink { [unowned self] _ in
				isLandscape = UIDevice.current.orientation.isLandscape
			}
			.store(in: &cancellables)
	}
	
	private var cancellables = Set<AnyCancellable>()
	
	@Published private(set) var isLandscape = UIDevice.current.orientation.isLandscape
}
