//
//  CardView.swift
//  Etalide
//
//  Created by Gregor Hermanowski on 26/05/22.
//

import SwiftUI

struct CardView: View {
	@Environment(\.editMode) private var editMode
	
	@State private var showImagePicker = false
	@State private var cardName = ""
	@State private var image: UIImage?
	@State private var imageID: String?
	
    var body: some View {
		ZStack(alignment: .bottom) {
			Button {
				showImagePicker.toggle()
			} label: {
				Group {
					if let image = image {
						Image(uiImage: image)
							.resizable()
					} else {
						Label("Choose an image", systemImage: "camera.fill")
							.labelStyle(.iconOnly)
							.font(.largeTitle)
					}
				}
				.frame(width: 300, height: 400)
				.background(Color.gray.opacity(0.5))
			}
			.disabled(editMode?.wrappedValue != .active)
			
			VStack {
				if let imageID = imageID {
					Text(imageID)
				}
				
				
				TextField("Name", text: $cardName)
					.font(.largeTitle.weight(.bold))
					.foregroundColor(.white)
					.multilineTextAlignment(.center)
					.frame(maxWidth: .infinity)
					.padding(.vertical)
					.background(.ultraThinMaterial)
			}
		}
		.frame(width: 300, height: 400)
		.cornerRadius(20)
		.sheet(isPresented: $showImagePicker) {
			ImagePicker(image: $image, imageID: $imageID)
		}
		.onChange(of: editMode?.wrappedValue) { editMode in
			if let editMode = editMode,
			   editMode == .inactive {
				
			}
		}
	}
}

struct CardView_Previews: PreviewProvider {
	static var previews: some View {
		CardView()
	}
}
