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
        
//        ZStack {
            
            Image(imageTitle)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaledToFit()
                .overlay {
                    Text(title)
                        .foregroundColor(.white)
                        .bold()
                        .font(.title)
                        .padding()
                }
            // background
//            VStack (alignment: .leading) {
//
//                //Spacer (minLength: UIScreen.main.bounds.height * 0.02)
//                Spacer ()
//                HStack {
//
//                    Text(title)
//                        .foregroundColor(.white)
//                        .bold()
//                        .font(.title)
//                        .padding()
//
//                    Spacer()
//                }
//                Spacer()
//
//            }
//            .padding()
//        }
//        .background(.red)
        
    }
}
struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(imageTitle: "FlashcardButton", title: "Play")
    }
}
