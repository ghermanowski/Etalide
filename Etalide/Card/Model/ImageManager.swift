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
	
	func find(withName imageName: String) -> UIImage? {
		let fileURL = fileURL(for: imageName)
		
		do {
			let data = try Data(contentsOf: fileURL)
			return UIImage(data: data)
		} catch {
			print(error.localizedDescription)
			return nil
		}
	}
	
	func save(_ imageData: Data, withName imageName: String) {
		let fileURL = fileURL(for: imageName)
		
		do {
			try imageData.write(to: fileURL)
		} catch {
			print(error.localizedDescription)
		}
	}
	
	func delete(withName imageName: String) {
		let fileURL = fileURL(for: imageName)
		
		do {
			try fileManager.removeItem(at: fileURL)
		} catch {
			print(error.localizedDescription)
		}
	}
	
	func fileURL(for imageName: String) -> URL {
		imagesURL.appendingPathComponent(imageName)
	}
}
