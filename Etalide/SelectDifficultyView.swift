//
//  SelectDifficultyView.swift
//  Etalide
//
//  Created by Antonio Scognamiglio on 30/05/22.
//

import SwiftUI

struct SelectDifficultyView: View {
	var body: some View {
		
		VStack(alignment: .leading, spacing: 10){
			Text("Play Memory")
				.font(.largeTitle)
				.foregroundColor(.white)
			
			Text("Choose the difficulty")
				.font(.headline)
				.foregroundColor(.white)
				.padding(.bottom, 20)
			
			ForEach(MemoryDifficulty.allCases) { difficulty in
				Text(difficulty.rawValue)
					.font(.title.weight(.semibold))
					.foregroundColor(.white)
					.padding(.vertical)
					.frame(maxWidth: .infinity)
					.padding(6)
					.background {
						RoundedRectangle(cornerRadius: 15)
							.foregroundColor(Color(difficulty.rawValue))
					}
					.padding(.bottom, 8)
					.padding(.horizontal, 20)
			}
			
			Button {
				
			} label: {
				Text("Cancel")
					.font(.title2.weight(.medium))
					.padding(.vertical)
					.frame(maxWidth:.infinity)
			}
			.tint(.white)
			.contentShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
			.padding(.top, 10)
		}
		.padding(32)
		.background {
			Color(red: 0.094, green: 0.149, blue: 0.259)
				.clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
		}
		.frame(width: 500, height: 400)
	}
}

struct SelectDifficultyView_Previews: PreviewProvider {
	static var previews: some View {
		SelectDifficultyView()
	}
}
