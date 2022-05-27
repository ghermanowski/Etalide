//
//  ImageManager.swift
//  Etalide
//
//  Created by Gregor Hermanowski on 26/05/22.
//

import Foundation
import UIKit

class ImageManager {
	private static let imagesPath = "Images"
	static let shared = ImageManager()
	
	private init() {}
	
	private let fileManager = FileManager.default
	
	func find(_ imageName: String) -> UIImage? {
		guard let fileURL = fileURL(for: imageName) else { return nil }
		
		do {
			let data = try Data(contentsOf: fileURL)
			return UIImage(data: data)
		} catch {
			print(error.localizedDescription)
			return nil
		}
	}
	
	func save(_ imageData: Data, withName imageName: String) {
		guard let fileURL = fileURL(for: imageName) else { return }
		
		do {
			try imageData.write(to: fileURL)
		} catch {
			print(error.localizedDescription)
		}
	}
	
	private func fileURL(for imageName: String) -> URL? {
		guard let documentsURL = try? fileManager.url(
			for: .documentDirectory,
			in: .userDomainMask,
			appropriateFor: nil,
			create: true
		) else {
			print("Documents directory not found.")
			return nil
		}
		
		let imagesURL = documentsURL.appendingPathComponent(Self.imagesPath)
		
		if !fileManager.fileExists(atPath: imagesURL.relativePath) {
			do {
				try fileManager.createDirectory(
					at: imagesURL,
					withIntermediateDirectories: false
				)
			} catch {
				print("\(Self.imagesPath) directory could not be created: \(error.localizedDescription)")
				return nil
			}
		}
		
		return imagesURL
			.appendingPathComponent(imageName)
	}
}
