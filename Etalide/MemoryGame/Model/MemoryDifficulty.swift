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
			case .easy: return 2
			case .medium: return 4
			case .hard: return 6
		}
	}
	
	var verticalColumns: Int {
		switch self {
			case .easy: return 2
			case .medium: return 4
			case .hard: return 4
		}
	}
	
	var horizontalColumns: Int {
		switch self {
			case .easy: return 4
			case .medium: return 4
			case .hard: return 6
		}
	}
}
