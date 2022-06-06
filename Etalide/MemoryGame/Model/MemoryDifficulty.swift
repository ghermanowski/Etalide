//
//  MemoryDifficulty.swift
//  Etalide
//
//  Created by Antonio Scognamiglio on 30/05/22.
//

import Foundation

enum MemoryDifficulty: String, CaseIterable, Identifiable {
	case easy = "Easy"
	case medium = "Medium"
	case hard = "Hard"
	
	var id: String { rawValue }
	
	var amount: Int {
		switch self {
		case .easy: return 6
		case .medium: return 9
		case .hard: return 12
		}
	}
	
	var columns: Int {
		switch self {
			case .easy: return 6
			case .medium: return 6
			case .hard: return 8
		}
	}
}
