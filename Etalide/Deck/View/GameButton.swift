//
//  GameButton.swift
//  Etalide
//
//  Created by Galina Aleksandrova on 26/05/22.
//

import SwiftUI

struct GameButton: View {
    let imageTitle: String
    let title: String
	
	var body: some View {
		Image(imageTitle)
			.resizable()
			.scaledToFit()
			.clipShape(RoundedRectangle(cornerRadius: 35, style: .continuous))
			.overlay(alignment: .topLeading) {
				Text(String(localized: String.LocalizationValue(title)))
					.font(.title.weight(.bold))
                    .multilineTextAlignment(.leading)
					.foregroundColor(.white)
					.padding(.leading, 8)
					.padding(20)
			}
    }
}
struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        GameButton(imageTitle: "FlashcardButton", title: "Play")
    }
}
