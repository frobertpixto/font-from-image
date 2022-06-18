//
//  NSImage+fr.swift
//  GenerateFontImages
//
//  Created by Francois Robert on 2018-10-28.
//

import Cocoa

extension NSImage {
	
	func convertImageToGrayScale() -> NSImage {
		// Create image rectangle with current image width/height
		let imageRect: CGRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
		
		// Grayscale color space
		let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceGray()
		
		// Create bitmap content with current image size and grayscale colorspace
		let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
		let context = CGContext(data: nil, width: Int(UInt(self.size.width)), height: Int(UInt(self.size.height)), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
		
		// Draw image into current context, with specified rectangle using previously defined context (with grayscale colorspace)
		context.draw(self.cgImage!, in: imageRect)
		
		// Create bitmap image info from pixel data in current context
		let imageRef: CGImage = context.makeImage()!
		
		// Create a new NSImage object
		let newImage: NSImage = NSImage.init(cgImage: imageRef, size: imageRect.size)
		
		// Return the new grayscale image
		return newImage
	}
	
	private func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
		return CGRect(x: x, y: y, width: width, height: height)
	}
	
}

extension NSImage {
	
	// Save the image to a file
	func save(as fileName: String, fileType: NSBitmapImageRep.FileType = .png, at directory: URL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)) -> Bool {
		guard let tiffRepresentation = tiffRepresentation, directory.hasDirectoryPath, !fileName.isEmpty else { return false }
		do {
			
			
			self.lockFocus()
			
			try NSBitmapImageRep(data: tiffRepresentation)?
				.converting(to: NSColorSpace.genericGray, renderingIntent: NSColorRenderingIntent.perceptual)?
				.representation(using: fileType, properties: [:])?
				.write(to: directory.appendingPathComponent(fileName))
			
			self.unlockFocus()
			return true
		} catch {
			print(error)
			return false
		}
	}
}

fileprivate extension NSImage {
	
	// Create a CGImage from a NSImage
	var cgImage: CGImage? {
		var rect = CGRect.init(origin: .zero, size: self.size)
		return self.cgImage(forProposedRect: &rect, context: nil, hints: nil)
	}
	
}
