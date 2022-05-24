//
//  TestCardView.swift
//  Etalide
//
//  Created by Alessia Andrisani on 24/05/22.
//

import SwiftUI

struct TestCardView: View {
	@State var isFaceUp: Bool = false
	var content: String
	
	var body: some View {
		
		ZStack {
			let shape = RoundedRectangle(cornerRadius:20)
				
			if isFaceUp {
				shape.fill().foregroundColor(.white)
				shape.strokeBorder(lineWidth: 3).foregroundColor(.red)
				Text(content).font(.largeTitle)
			} else {
				shape.fill().foregroundColor(.red)
				
			}
		}
		.onTapGesture {
			isFaceUp = !isFaceUp
			
		}
	}
}

struct TestCardView_Previews: PreviewProvider {
    static var previews: some View {
        TestCardView(content: "🦄")
    }
}