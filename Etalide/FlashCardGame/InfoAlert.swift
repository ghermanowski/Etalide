//
//  InfoAlert.swift
//  Etalide
//
//  Created by Antonio Scognamiglio on 10/06/22.
//

import SwiftUI

struct InfoAlert: View {
	@Binding var isShowingAlert: Bool
	
	var body: some View {
		
			VStack(alignment: .center, spacing: 20) {
				Text("Instructions")
					.fontWeight(.bold)
					.font(.system(size: 40))
				Text("""
		 Swipe horizontaly for see the next card
		 Tap on the card to reveal the entire word
		 """)
					.font(.system(size: 30))
					.fontWeight(.medium)
					.multilineTextAlignment(.leading)
				Button(action: {
					self.isShowingAlert.toggle()
				} ) {
					Text("Ok")
						.foregroundColor(.blue)
						.fontWeight(.medium)
						.font(.system(size: 30))
				}
			}
			.padding(48)
			//.background {
				//Color.white.clipShape(RoundedRectangle(cornerRadius: 45)
				//	.strokeBorder(Color.accentColor, lineWidth: 10).foregroundColor(.white))
			//}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
}

struct MyAlert_Previews: PreviewProvider {
    static var previews: some View {
		InfoAlert(isShowingAlert: .constant(true))
    }
}
