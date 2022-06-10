//
//  ButtonView.swift
//  Etalide
//
//  Created by Galina Aleksandrova on 26/05/22.
//

import SwiftUI

struct ButtonView: View {
    let imageTitle: String
    let title: String
	
	var body: some View {
		Image(imageTitle)
			.resizable()
			.scaledToFit()
			.overlay(alignment: .topLeading) {
				Text(String(localized: String.LocalizationValue(title)))
					.font(.title.weight(.bold))
                    .multilineTextAlignment(.leading)
					.foregroundColor(.white)
					.padding(.leading, 8)
					.padding()
			}
    }
}
struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(imageTitle: "FlashcardButton", title: "Play")
    }
}
