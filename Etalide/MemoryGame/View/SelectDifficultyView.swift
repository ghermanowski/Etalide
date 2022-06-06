//
//  SelectDifficultyView.swift
//  Etalide
//
//  Created by Antonio Scognamiglio on 30/05/22.
//

import SwiftUI

struct SelectDifficultyView: View {
	let deck: Deck
	@Binding var isShowingDifficulties: Bool
	
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
				NavigationLink {
					MemoryView(deck: deck, difficulty: difficulty)
				} label: {
					
					// I don't know why this doesn't extract the String for Localisation.
					Text(String(localized: String.LocalizationValue(difficulty.rawValue)))
						.font(.title.weight(.semibold))
						.foregroundColor(.white)
						.padding(.vertical)
						.frame(maxWidth: .infinity)
						.background {
							RoundedRectangle(cornerRadius: 15)
								.foregroundColor(Color(difficulty.rawValue))
						}
//						.padding(.bottom, 8)
				}
			}
			
			Button {
				withAnimation {
					isShowingDifficulties = false
				}
			} label: {
				Text("Cancel")
					.font(.title2.weight(.medium))
					.padding(.vertical)
					.frame(maxWidth: .infinity)
					.tint(.white)
					.contentShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
			}
		}
		.padding(32)
		.background {
			Color(UIColor(.backgroundBlue))
				.clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
		}
	}
}

struct SelectDifficultyView_Previews: PreviewProvider {
	static var previews: some View {
		SelectDifficultyView(deck: Deck(), isShowingDifficulties: .constant(true))
			.previewInterfaceOrientation(.portraitUpsideDown)
	}
}
