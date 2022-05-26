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
				.frame(minWidth: 225, maxWidth: .infinity, minHeight: 300)
				.background(Color.gray.opacity(0.5))
			}
			
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
		.frame(minWidth: 225, minHeight: 300)
		.aspectRatio(3 / 4, contentMode: .fit)
		.cornerRadius(20)
		.disabled(editMode?.wrappedValue != .active)
		.sheet(isPresented: $showImagePicker) {
			ImagePicker(image: $image)
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
