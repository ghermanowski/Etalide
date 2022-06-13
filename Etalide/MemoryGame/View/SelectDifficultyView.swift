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
		VStack(alignment: .leading, spacing: 10) {
			LazyVStack(alignment: .leading, spacing: 8) {
				Text("Play Memory")
					.font(.title.weight(.bold))
				
				Text("Choose the difficulty")
					.font(.headline.weight(.medium))
			}
			.foregroundColor(.white)
			.multilineTextAlignment(.leading)
			.padding(.bottom, 20)
			
			ForEach(MemoryDifficulty.allCases) { difficulty in
				if difficulty.amount <= (deck.cards ?? []).count {
					NavigationLink {
						MemoryView(deck: deck, difficulty: difficulty)
					} label: {
						Text(String(localized: String.LocalizationValue(difficulty.rawValue)))
							.font(.title.weight(.semibold))
							.foregroundColor(.white)
							.padding(.vertical)
							.frame(maxWidth: .infinity)
							.background {
								RoundedRectangle(cornerRadius: 15)
									.foregroundColor(Color(difficulty.rawValue))
							}
					}
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
			Color(UIColor(.accentColor))
				.clipShape(RoundedRectangle(cornerRadius: 35, style: .continuous))
		}
		.transition(.opacity.combined(with: .scale(scale: 0.95, anchor: .top)))
	}
}

struct SelectDifficultyView_Previews: PreviewProvider {
	static var previews: some View {
		SelectDifficultyView(deck: Deck(), isShowingDifficulties: .constant(true))
			.previewInterfaceOrientation(.portraitUpsideDown)
	}
}
