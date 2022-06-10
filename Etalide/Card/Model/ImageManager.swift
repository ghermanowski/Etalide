//
//  ImageManager.swift
//  Etalide
//
//  Created by Gregor Hermanowski on 26/05/22.
//

import Foundation
import SwiftUI

/// Provides access to the Images directory.
class ImageManager {
	private static let imagesPath = "Images"
	
	// The shared image manager object for the process.
	static let shared = ImageManager()
	
	private init() {}
	
	private let fileManager = FileManager.default
	
	/// Stores previously loaded images.
	var cache = [URL: Image]()
	
	/// URL to the Images directory.
	private lazy var imagesURL: URL = {
		let documentsURL = try! fileManager.url(
			for: .documentDirectory,
			in: .userDomainMask,
			appropriateFor: nil,
			create: true
		)
		
		let imagesURL = documentsURL.appendingPathComponent(Self.imagesPath)
		
		if !fileManager.fileExists(atPath: imagesURL.relativePath) {
			try! fileManager.createDirectory(
				at: imagesURL,
				withIntermediateDirectories: false
			)
		}
		
		return imagesURL
	}()
	
	/// Attempts to save a file in the Images directory.
	/// - Parameters:
	///   - imageData: The image data.
	///   - imageName: The name for the image file.
	func save(_ imageData: Data, withName imageName: String) {
		let fileURL = fileURL(for: imageName)
		
		do {
			try imageData.write(to: fileURL)
			cache.removeValue(forKey: fileURL)
		} catch {
			print(error.localizedDescription)
		}
	}
	
	/// Attempts to delete a file from the Images directory.
	/// - Parameter imageName: The name of the image file that should be deleted.
	func delete(withName imageName: String) {
		let fileURL = fileURL(for: imageName)
		
		do {
			try fileManager.removeItem(at: fileURL)
		} catch {
			print(error.localizedDescription)
		}
	}
	
	/// Creates a URL to the file in the Images directory.
	/// - Parameter imageName: The name of the image file.
	/// - Returns: The URL to access the file.
	func fileURL(for imageName: String) -> URL {
		imagesURL.appendingPathComponent(imageName)
	}
}
