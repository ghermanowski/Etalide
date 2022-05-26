//
//  DeckGridView.swift
//  Etalide
//
//  Created by Diego Castro on 25/05/22.


import SwiftUI



struct DeckGridView: View {
    @State private var numberOfDecks: Int = 3
    @State private var orientation = UIDeviceOrientation.unknown
    @State var columns = Array(repeating: GridItem(.flexible(),spacing: 20), count: 3)
    
    
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
                            .frame(width: UIScreen.main.bounds.width*1/36,
                                   alignment: .center)
                        
                        Text ("New Deck ")
                            .font(.custom("Arial", size: 20))
                    }
                }
            }
        } .aspectRatio(contentMode: .fit)
    }
    
	@State private var showDeck = false
	
    /// Builds the preview of the available decks
    /// - Parameter numberOfDecks: The number of decks available for the user. This function is called inside a ForEach cicle.
    /// - Returns: A Preview of each available deck
    func deckPreview(numberOfDecks: Int) -> some View  {
        
        Button {
			showDeck.toggle()  // TODO: Change to selected Deck
        } label: {
            ZStack {
                roundedRectangleStroke(cornerRadious: 25, width: orientation.isLandscape ?  UIScreen.main.bounds.width*(cardWidthLandscape):UIScreen.main.bounds.width*(cardWidthPortrait) , height: orientation.isLandscape == true ?  UIScreen.main.bounds.height*(cardHeightLandscape): UIScreen.main.bounds.height*(cardHeightPortrait), strokeColor: Color(UIColor.lightGray), lineWidth: 8, alignment: .center)
                
                roundedRectangleFilled(cornerRadious: 25, width: orientation.isLandscape ?  UIScreen.main.bounds.width*(cardWidthLandscape): UIScreen.main.bounds.width*(cardWidthPortrait), height: orientation.isLandscape ? UIScreen.main.bounds.height*(cardHeightLandscape):UIScreen.main.bounds.height*(cardHeightPortrait), color: Color(UIColor.lightGray).opacity(0.2), alignment: .center)
            }
			.aspectRatio(contentMode: .fit)
        }
    }
    var body: some View {
        NavigationView {
            VStack {
                
//                Text("Choose a Deck")
//                    .foregroundColor(Color( UIColor.blue))
//                    .font(.largeTitle).bold()
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding()
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        Group {
                            if numberOfDecks == 0 {
                                createNewDeckButton()
                            } else if numberOfDecks == 1 {
                                createNewDeckButton()
                                deckPreview(numberOfDecks: numberOfDecks)
                            } else {
                                ForEach(0...numberOfDecks-1, id: \.self) {
                                    item in
                                    
                                    if item == 0 {
                                        createNewDeckButton()
                                    }
									
									deckPreview(numberOfDecks: item)
                                }
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
                    }
                    .padding(.horizontal)
                }
                .frame(maxHeight: .infinity)
            }
            .navigationTitle("Decks")
			.sheet(isPresented: $showDeck) {
				DeckView()
			}
        }
        .navigationViewStyle(.stack)
    }
}

struct DeckGridView_Previews: PreviewProvider {
    static var previews: some View {
        DeckGridView()
    }
}
