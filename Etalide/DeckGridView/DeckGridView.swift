//
//  DeckGridView.swift
//  Etalide
//
//  Created by Diego Castro on 25/05/22.


import SwiftUI



struct DeckGridView: View {
	@Environment(\.managedObjectContext) private var moc
	
    @State private var orientation = UIDeviceOrientation.unknown
    @State var columns = Array(repeating: GridItem(.flexible(),spacing: 20), count: 3)
	@State private var selectedDeck: Deck?
    
	@FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) private var decks: FetchedResults<Deck>
    
    //Mark: Specifying width and hight of the decks preview depending on the orientation of the device. The numbers are proportions of the available area (not absolute sizes)
    let cardWidthLandscape:CGFloat = 2.3/10
    let cardHeightLandscape:CGFloat = 4/10
    let cardWidthPortrait:CGFloat = 3/10
    let cardHeightPortrait:CGFloat = 3/10
    
    
    
    //    Mark: Creating a rounded rectabgle without stroke
    func roundedRectangleFilled (cornerRadious: Double, width: Double, height: Double, color: Color, alignment: Alignment ) -> some View {
        return RoundedRectangle(cornerRadius: cornerRadious, style: .continuous)
            .fill(color)
            .frame(width: width,
                   height: height,
                   alignment: alignment)
        
    }
    
    //    Mark: Creating the stroke for the rectangle
    func roundedRectangleStroke (cornerRadious: Double, width: Double, height: Double, strokeColor: Color, lineWidth: Double, alignment: Alignment ) -> some View {
        return RoundedRectangle(cornerRadius: cornerRadious, style: .continuous)
            .strokeBorder(strokeColor, lineWidth: lineWidth)
            .frame(width: width,
                   height: height,
                   alignment: alignment)
        
    }
    
    
    /// Build the "New Deck" Button
    /// - Returns: A view of the actual button
    func createNewDeckButton() -> some View  {
        ZStack {
            Button {
                _ = Deck(context: moc, name: "TestDeck")
				saveContext()
            } label: {
                ZStack {
                    roundedRectangleStroke (cornerRadious: 25, width: UIScreen.main.bounds.width*(orientation.isLandscape ? cardWidthLandscape: cardWidthPortrait), height: UIScreen.main.bounds.height*( orientation.isLandscape ? cardHeightLandscape:cardHeightPortrait), strokeColor: Color(UIColor.lightGray), lineWidth: 8, alignment: .center)
                    
                    roundedRectangleFilled(cornerRadious: 25, width:  UIScreen.main.bounds.width*(orientation.isLandscape ? cardWidthLandscape: cardWidthPortrait),
                                           height: UIScreen.main.bounds.height*( orientation.isLandscape ? cardHeightLandscape:cardHeightPortrait), color: Color(UIColor.lightGray).opacity(0.2),
                                           alignment: .center)
                    
                    VStack {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color(UIColor.systemBlue))
                            .frame(width: UIScreen.main.bounds.width*1/36,
                                   alignment: .center)
                        
                        Text ("New Deck ")
                            .font(.custom("Arial", size: 20))
                            .foregroundColor(Color(UIColor.systemBlue))
                    }
                }
            }
        }
		.aspectRatio(contentMode: .fit)
    }
    
	
    /// Builds the preview of the available decks
    /// - Parameter numberOfDecks: The number of decks available for the user. This function is called inside a ForEach cicle.
    /// - Returns: A Preview of each available deck
	func deckPreview(_ deck: Deck) -> some View  {
        
        Button {
			selectedDeck = deck
        } label: {
            ZStack {
                roundedRectangleStroke(cornerRadious: 25, width: orientation.isLandscape ?  UIScreen.main.bounds.width*(cardWidthLandscape):UIScreen.main.bounds.width*(cardWidthPortrait) , height: orientation.isLandscape ?  UIScreen.main.bounds.height*(cardHeightLandscape): UIScreen.main.bounds.height*(cardHeightPortrait), strokeColor: Color(UIColor.lightGray), lineWidth: 8, alignment: .center)
					.overlay {
						if let firstCard = deck.allCards?.first,
						   let image = firstCard.image {
							Image(uiImage: image)
								.resizable()
								.cornerRadius(25)
						}
					}
				
                roundedRectangleFilled(cornerRadious: 25, width: orientation.isLandscape ?  UIScreen.main.bounds.width*(cardWidthLandscape): UIScreen.main.bounds.width*(cardWidthPortrait), height: orientation.isLandscape ? UIScreen.main.bounds.height*(cardHeightLandscape):UIScreen.main.bounds.height*(cardHeightPortrait), color: Color(UIColor.lightGray).opacity(0.2), alignment: .center)
				
				Text(deck.wrappedName)
					.font(.largeTitle.bold())
					.foregroundColor(.white)
            }
			.aspectRatio(contentMode: .fit)
        }
    }
	
	var body: some View {
		ScrollView {
			LazyVGrid(columns: columns, spacing: 20) {
				createNewDeckButton()
				
				ForEach(decks) { deck in
					deckPreview(deck)
				}
			}
			.onRotate { newOrientation in
				orientation = newOrientation
				
				if orientation.isLandscape {
					columns = Array(repeating: GridItem(.flexible(),spacing: 20), count: 4)
				} else {
					columns = Array(repeating: GridItem(.flexible(),spacing: 20), count: 3)
				}
			}
			.padding(.all)
		}
		.frame(maxHeight: .infinity)
		.navigationTitle("Decks")
		.sheet(item: $selectedDeck) { deck in
			DeckView(deck)
		}
	}
	
	private func saveContext() {
		do {
			try moc.save()
		} catch {
			fatalError("Unresolved error: \(error.localizedDescription)")
		}
	}
}

struct DeckGridView_Previews: PreviewProvider {
    static var previews: some View {
        DeckGridView()
    }
}
