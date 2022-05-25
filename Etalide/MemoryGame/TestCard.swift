//
//  TestCard.swift
//  Etalide
//
//  Created by Alessia Andrisani on 25/05/22.
//

import Foundation

struct TestCard: Identifiable, Equatable {
	var id: UUID
	let emoji: String
	
	
	static func == (lhs: TestCard, rhs: TestCard) -> Bool {
		lhs.id == rhs.id
	}
	
	static var example = TestCard(id: UUID(), emoji: "😍")
}
