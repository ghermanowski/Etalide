//
//  CardImageView.swift
//  Etalide
//
//  Created by Gregor Hermanowski on 31/05/22.
//

import SwiftUI

struct CardImageView: View {
	init(_ url: URL) {
		self.url = url
	}
	
	private let url: URL
	
	var body: some View {
		AsyncImage(url: url) { image in
			image
				.resizable()
				.aspectRatio(3 / 4, contentMode: .fit)
		} placeholder: {
			ProgressView()
		}
	}
}

struct CardImageView_Previews: PreviewProvider {
    static var previews: some View {
        CardImageView(URL(string: "https://images.unsplash.com/photo-1573865526739-10659fec78a5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1015&q=80")!)
    }
}