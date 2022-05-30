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
}
