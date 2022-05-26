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
            
            VStack (spacing: 20) {
                
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
