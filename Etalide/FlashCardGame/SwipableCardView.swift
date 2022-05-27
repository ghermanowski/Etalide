//
//  SwipableCardView.swift
//  Etalide
//
//  Created by Galina Aleksandrova on 16/05/22.
//

import SwiftUI

struct SwipableCardView: View {
    @State private var translation: CGSize = .zero
    @State var selectateCardsPlaceholder = [TestCard]()
    
    private var card: Card
    private var onRemove: (Card) -> Void
    
    init(card: Card, onRemove: @escaping (Card) -> Void) {
        self.card = card
        self.onRemove = onRemove
    }
    
    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / geometry.size.width
    }
    
    var body: some View {
        GeometryReader { geometry in
			
            CardView(card)
			
            //Update the offset of the view based on whatever values are in the width/height of our translation. This will move the view exactly where we are dragging it.
            //only horizontal dragging
                .offset(x: translation.width, y: 0)
            //horizontal and vertical dragging
//                .offset(x: self.translation.width, y: self.translation.height)
            //to rotate
                .rotationEffect(.degrees(Double(translation.width / geometry.size.width) * 25), anchor: .bottom)
                .gesture(
                    // when the user has draged 50% the width of the screen in either direction
                    DragGesture()
                    //Update our translation variable to the new value of our drag as well as reset our translation back to 0 in the .onEnded
                        .onChanged { value in
                            translation = value.translation
                        }
                        .onEnded { value in
                            // determine snap distance > half the width of the screen
                            if abs(getGesturePercentage(geometry, from: value)) > 0.5 {
                                onRemove(card)
                            } else {
                                translation = .zero
                            }
                        }
                )
        }
    }
}

struct FlashCardGameView_Previews: PreviewProvider {
    static var previews: some View {
        SwipableCardView(card: Card()) { _ in
            // do nothing
        }
        .padding()
    }
}
