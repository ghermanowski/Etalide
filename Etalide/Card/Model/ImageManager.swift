//
//  ImageManager.swift
//  Etalide
//
//  Created by Gregor Hermanowski on 26/05/22.
//

import Foundation
import UIKit

class ImageManager {
	static let shared = ImageManager()
	
	private init() {}
	
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
		guard let folderURL = try? FileManager.default.url(
			for: .documentDirectory,
			in: .userDomainMask,
			appropriateFor: nil,
			create: true
		) else {
			return nil
		}
		
		return folderURL.appendingPathComponent("images/" + imageName)
	}
}
