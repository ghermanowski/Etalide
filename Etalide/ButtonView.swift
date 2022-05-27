//
//  ButtonView.swift
//  Etalide
//
//  Created by Galina Aleksandrova on 26/05/22.
//

import SwiftUI

struct ButtonView: View {
    let title: String
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(.gray)
            
            VStack (alignment: .leading) {
                Spacer (minLength: UIScreen.main.bounds.height * 0.02)
            Text(title)
                .foregroundColor(.white)
                .font(.title)
                
            Spacer()
                
        }
    }
        
}
}
struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(title: "Play")
    }
}
