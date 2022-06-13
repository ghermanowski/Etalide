//
//  SwipableCardView.swift
//  Etalide
//
//  Created by Galina Aleksandrova on 16/05/22.
//

import SwiftUI

struct SwipableCardView: View {
    
	@State var showFirstLetter = true
    @State private var translation: CGSize = .zero
	
    @ScaledMetric private var fontSize = 64
	
    private var card: Card
    private var onRemove: (_ card: Card) -> Void
    //swiping percentage
    private var thresholdPercentage: CGFloat = 0.05
    
    init(card: Card, onRemove: @escaping (_ card: Card) -> Void) {
        self.card = card
        self.onRemove = onRemove
    }
    
    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / geometry.size.width
    }
    
	@ViewBuilder var cardView: some View {
		if let imageURL = card.imageURL {
			CardImageView(imageURL)
				.overlay(alignment: .bottom) {
					if let cardName = card.name {
						Text(showFirstLetter ? String(cardName.prefix(1)) : cardName)
							.font(.system(size: fontSize, weight: .bold))
							.foregroundStyle(Color.background)
							.multilineTextAlignment(.center)
							.frame(maxWidth: .infinity)
							.padding(.vertical)
							.background(Color.accentColor)
					}
				}
				.clipShape(RoundedRectangle(cornerRadius: 45, style: .continuous))
				.onTapGesture {
					withAnimation {
						showFirstLetter.toggle()
					}
				}
		}
	}
	
    var body: some View {
        GeometryReader { geometry in
			cardView
                .frame(width: geometry.size.width, height: geometry.size.height)
            //Update the offset of the view based on whatever values are in the width/height of our translation. This will move the view exactly where we are dragging it.
            //only horizontal dragging
                .offset(x: self.translation.width, y: 0)
            //horizontal and vertical dragging
            //to rotate
                .rotationEffect(.degrees(Double(self.translation.width / geometry.size.width) * 25), anchor: .bottom)
                .gesture(
                    // when the user has draged 50% the width of the screen in either direction
                    DragGesture()
                    //Update our translation variable to the new value of our drag as well as reset our translation back to 0 in the .onEnded
                        .onChanged { value in
                            translation = value.translation
                        }
                        .onEnded ({ value in
                            // determine snap distance > 0.5 aka half the width of the screen
                            if abs(self.getGesturePercentage(geometry, from: value)) > self.thresholdPercentage {
                                self.onRemove(self.card)
                            } else {
                                self.translation = .zero
                            }
                        })
                )
        }
    }
}

struct SwipableCardView_Previews: PreviewProvider {
    static var previews: some View {
        SwipableCardView(card: Card()) { _ in
            // do nothing
        }
        .padding()
    }
}
