//
//  FontGenerator.swift
//  GenerateFontImages. Generate images using texts and fonts to produce data for Machine Learning experiments.
//
//  Created by Francois Robert on 2018-10-28.
//

import Foundation
import Cocoa

enum ShadowStyle {
	case none
	case typical
}

enum BorderStyle {
	case none
	case blackWithFilled
}

class FontGenerator
{
	func generateFontImages() {
	
		let fillColor      = NSColor(white: 1.0, alpha: 1.0) // White
		let textColor      = NSColor(white: 0.0, alpha: 1.0) // Black
		
		// List of 35 fonts. These fonts are available on MacOS or they are Google fonts. See: https://fonts.google.com
		let fontNames      = [
			"Aladin-Regular",
			"AlexBrush-Regular",
			"Allura-Regular",
			"AmaticSC-Regular",
			"AmericanTypewriter-Condensed",
			"Bonbon-Regular",
			"BowlbyOneSC-Regular",
			"BradleyHandITCTT-Bold",
			"BrushScriptMT",
			"CarterOne",
			"Chalkduster",
			"Cookie-Regular",
			"Copperplate",
			"CourierNewPSMT",
			"Damion",
			"DancingScript-Bold",
			"Didot",
			"FredokaOne-Regular",
			"Futura-CondensedMedium",
			"GochiHand-Regular",
			"GrandHotel-Regular",
			"GreatVibes-Regular",
			"Helvetica-Bold",
			"HelveticaNeue",
			"Impact",
			"Luminari-Regular",
			"MarkerFelt-Thin",
			"Noteworthy-Light",
			"Optima-Regular",
			"Pacifico-Regular",
			"RockSalt",
			"Rockwell-Regular",
			"Shojumaru-Regular",
			"TimesNewRomanPSMT",
			"Yesteryear-Regular",
		]
		
		
		// Triplets
		// First iteration based on common 2 letter pairs from : http://homepages.math.uic.edu/~leon/mcs425-s08/handouts/char_freq2.pdf
		// Other references to consider:
		// - https://en.wikipedia.org/wiki/Letter_frequency
		// - https://www3.nd.edu/~busiforc/handouts/cryptography/letterfrequencies.html
		//
		// Ideally, we should determine ourself frequent triplets based on a long sample of text (ex: Wikipedia)
		// As for why ENGLISH text? Well, money makes the world go round! (Cabaret)
		//
		// We will generate rectangular images from each of these triplets
		let triplets: Set =
			            ["The", "Ath", "Pan", "Yer", "And", "Are", "Ted", "Ies", "Hou", "Ato", "Hav", "Men", "Sea",
		                "Sto", "Ent", "Ont", "Cat", "Whi", "Has", "Bit", "Ing", "Mis", "For", "Set", "Cof", "Tit",
		                "Tha", "Uth", "Ann", "Eer", "Ond", "Ire", "Med", "Pes", "Rou", "Tom", "Pha", "Eng", "Eat",
							 "Ist", "Ant", "Pon", "Att", "Hit", "Ask", "Itc", "Ngi", "Ord", "Ett", "Off", "Tim", "Thi",
							 "Car", "Tea", "Sed", "Mem", "Sal", "Neo", "Wac", "Ave", "Ole", "Nno", "Tat", "Ale", "Deb",
							 "Vot", "Son", "Odt", "Ill", "Utt", "Rel", "Rom", "Bad", "Die", "Few", "Ran", "Riv", "Ush",
							 "Whe", "Her", "Can", "ada", "isa", "cou", "ntr", "yin", "hen", "ort", "ern", "par", "tof",
							 "Nor", "thA", "mer", "ica", "tst", "enp", "rov", "inc", "esa", "ndt", "hre", "ete", "rri",
							 "tor", "ies", "ext", "ndf", "omt", "heA", "tla", "nti", "cto", "heP", "aci", "fic", "ndn",
							 "hwa", "rdi", "nto", "eAr", "cti", "cOc", "ean", "hil"]

		// We will generate square images from each of these letters
		let lettersToDisplay = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@#?%&Çéèêëïîīçàâãôõóùúüũ"
		
//		let shadows        = [ShadowStyle.none, ShadowStyle.typical]
//		let borderStyles   = [BorderStyle.none, BorderStyle.blackWithFilled]
		let shadows        = [ShadowStyle.none]
		let borderStyles   = [BorderStyle.none]
		
		var fontDirGenerated = 0

		let directoryVersion = "prep1"
		let baseDir = NSTemporaryDirectory() + String(format:"%@/input", directoryVersion) 
		print("Font data will be created in: \(baseDir)")
		
		for fontName in fontNames {
			let fontDir  = String(format:"%@/font_data/%@", baseDir, fontName)
			do {
				try createDir(dir: fontDir)
				
				// Create square images with only 1 character
				for charToDisplay in lettersToDisplay {
					
					var countForLetter = 0
					for shadow in shadows {
						for borderStyle in borderStyles {
							let letterToDisplay = String(charToDisplay)
							let fileName = String(format:"%@$$%@.%l05d.png", fontName, unicode8String(oneCharacter: letterToDisplay), countForLetter)
							
							let image = createImageForText(fontName: fontName, textToDisplay: letterToDisplay, textColor: textColor, fillColor: fillColor, shadowStyle: shadow, borderStyle: borderStyle)
							let _ = image.save(as: fileName, fileType: NSBitmapImageRep.FileType.png, at: URL(fileURLWithPath: fontDir))

							countForLetter += 1
						}
					}
				}

				// Create rectangular images with 3 characters
				for triplet in triplets {
					
					for shadow in shadows {
						for borderStyle in borderStyles {
							// as is case
							let fileName = String(format:"%@$$%@.%l05d.png", fontName, unicode8String(oneCharacter: triplet), 0)
							
							let image = createImageForText(fontName: fontName, textToDisplay: triplet, textColor: textColor, fillColor: fillColor, shadowStyle: shadow, borderStyle: borderStyle)
							let _ = image.save(as: fileName, fileType: NSBitmapImageRep.FileType.png, at: URL(fileURLWithPath: fontDir))

							// Uppercase
							let fileNameU = String(format:"%@$$%@.%l05d.png", fontName, unicode8String(oneCharacter: triplet.uppercased()), 0)
							
							let imageU = createImageForText(fontName: fontName, textToDisplay: triplet.uppercased(), textColor: textColor, fillColor: fillColor, shadowStyle: shadow, borderStyle: borderStyle)
							let _ = imageU.save(as: fileNameU, fileType: NSBitmapImageRep.FileType.png, at: URL(fileURLWithPath: fontDir))
						}
					}
				}
				
				fontDirGenerated += 1
			} catch {
				Swift.print("error in creating dir -> \(fontDir)")
			}
			
			// Show progression as a dot per font.
			print(".", terminator:"")
		}
		
		let nb_1_char  = lettersToDisplay.count * shadows.count * borderStyles.count
		let nb_3_chars = triplets.count * 2 * shadows.count * borderStyles.count // Because normal case + upper case

		// We will also generate a JSON parameter file.
		let dictParams: NSDictionary = ["nb_1_char" : nb_1_char, "nb_3_chars": nb_3_chars]
		let _ = serialize(dict: dictParams, toJSONFile: String(format:"%@/%@.param.json", baseDir, directoryVersion))

		Swift.print("\nFont Dir generated: \(fontDirGenerated)")
	}
	
	func unicode8String(oneCharacter: String) -> String {
		if oneCharacter.count < 1  {
			return "Unknown"
		}
		
		var result = ""
		
		for char in oneCharacter.utf8 {
			let padded = "0000" + String(char, radix: 16)
			result    += "U" + String(padded.suffix(4))
		}
		
		return result
	}
	
	func createImageForText(fontName: String, textToDisplay: String, textColor: NSColor, fillColor: NSColor, shadowStyle : ShadowStyle, borderStyle : BorderStyle) -> NSImage {
		let imageSize: CGFloat = 50.0

		let nbChar = textToDisplay.count
		let size   = NSMakeSize(CGFloat(nbChar) * imageSize, imageSize)
		let image  = NSImage.init(size: size)
		let rect   = NSRect(origin: CGPoint(x: 0, y: 0), size: size)
		
		let rep = NSBitmapImageRep.init(bitmapDataPlanes: nil,
												  pixelsWide: Int(size.width),
												  pixelsHigh: Int(size.height),
												  bitsPerSample: 8,
												  samplesPerPixel: 4,
												  hasAlpha: true,
												  isPlanar: false,
												  colorSpaceName: NSColorSpaceName.calibratedRGB,
												  bytesPerRow: 0,
												  bitsPerPixel: 0)
		
		image.addRepresentation(rep!)
		image.lockFocus()
		
		let rectPath:NSBezierPath = NSBezierPath(rect: rect)
		fillColor.set()
		rectPath.fill()
		
		// Start with a bigger font size when estimating the correct font size to fit in the image for each font.
		let initialFontSize : CGFloat       = 200.0
		
		// 3
		let (textSize, bestFontSize) = calculateSizeForText(text: textToDisplay, contrainedHeight: size.height, fontSize: initialFontSize, fontName: fontName)

		// Shadow
		let shadow = NSShadow()
		if shadowStyle == .typical {
			shadow.shadowColor = NSColor.black
			shadow.shadowBlurRadius = 3
			shadow.shadowOffset = NSSize(width: 2, height: -2)
		}
		
		// Border
		let borderValue = borderStyle == .blackWithFilled ? -4 : 0
		
		let paragraphStyle           = NSMutableParagraphStyle()
		paragraphStyle.lineBreakMode = .byClipping
		paragraphStyle.alignment     = .center

		let nameTextAttributes = [
			NSAttributedString.Key.font.rawValue: NSFont(name: fontName, size: bestFontSize),
			NSAttributedString.Key.foregroundColor.rawValue: textColor,
			NSAttributedString.Key.strokeColor.rawValue: NSColor.black,
			NSAttributedString.Key.strokeWidth.rawValue: NSNumber(value: borderValue),   // 0: No Stroke. Positive: Stroke Only. Negative: Stroke + Fill
			NSAttributedString.Key.shadow.rawValue: shadow,
			NSAttributedString.Key.paragraphStyle.rawValue: paragraphStyle]

		let coreTextFont 	= CTFontCreateWithName(fontName as CFString, bestFontSize, nil)
//		let capHeight 		= CTFontGetCapHeight(coreTextFont)
		let descent 		= CTFontGetDescent(coreTextFont)
//		let ascent 			= CTFontGetAscent(coreTextFont)

		// Draw the text onto the image
		textToDisplay.draw(at: NSPoint(x: (size.width - textSize.width) / 2, y: -descent+10), withAttributes: convertToOptionalNSAttributedStringKeyDictionary(nameTextAttributes as [String : Any]))
		
		image.unlockFocus()
		
		return image
	}
	
	
	func createDir(dir: String) throws {
		let manager = FileManager.default
		try manager.createDirectory(atPath: dir, withIntermediateDirectories: true)
	}
	
	
	// Helper function inserted by Swift 4.2 migrator.
	fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
		guard let input = input else { return nil }
		return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
	}
	
	
	// Estimate the correct font size to fit in the image size. Also return the actual CGSize that would be used to draw
	func calculateSizeForText(text: String, contrainedHeight: CGFloat, fontSize: CGFloat, fontName: String) -> (CGSize, CGFloat) { // Return the size of the text rectangle and the font size that almost fit the Rectangle
		let coreTextFont = CTFontCreateWithName(fontName as CFString, fontSize, nil)
		
		// Create text with the following attributes
		let attributes = [
			NSAttributedString.Key.font : coreTextFont
		]
		
		let attributedString = NSMutableAttributedString(string:text, attributes:attributes)
		let line =  CTLineCreateWithAttributedString(attributedString)
		
		var ascent : CGFloat = 0
		var descent: CGFloat = 0
		var leading: CGFloat = 0
		
		var width    = CGFloat(CTLineGetTypographicBounds(line, &ascent, &descent, &leading))
		var ctHeight = ascent + descent // + leading
		
		let capHeight = CTFontGetCapHeight(coreTextFont)
		
		ctHeight = capHeight + descent  // This is more agressive
		
		
		var estimatedFontSize = CGFloat(ceilf( Float(contrainedHeight * fontSize / ctHeight))) + 1
		var calculatedHeight	 = CGFloat(1000000)
		
		// Decrease the font size until it the text fits in the drawing space
		while calculatedHeight > contrainedHeight+0.0001 && estimatedFontSize > 2.0 {
			estimatedFontSize -= 0.5
			
			let fontRef = CTFontCreateWithName(fontName as CFString, estimatedFontSize, nil)
			
			// Create text with the following attributes
			let attributes = [
				NSAttributedString.Key.font : fontRef
			]
			
			let attributedString = NSMutableAttributedString(string:text, attributes:attributes)
			let line =  CTLineCreateWithAttributedString(attributedString)

			let capHeight = CTFontGetCapHeight(fontRef)

			width            = CGFloat(CTLineGetTypographicBounds(line, &ascent, &descent, &leading))
			//calculatedHeight = ascent + descent // + leading
			//calculatedHeight = capHeight + descent // Very Agressive
			calculatedHeight = capHeight + ((ascent - capHeight) / 3) + descent // Agressive
		}
		
		return (CGSize(width: width, height: calculatedHeight), estimatedFontSize)
	}
	
	
	// Write a JSON array to a file
	func serialize(array: NSArray, toJSONFile: String) -> Bool
	{
		if JSONSerialization.isValidJSONObject(array) {
			do {
				let jsonData = try JSONSerialization.data(withJSONObject: array, options: .prettyPrinted)
				try jsonData.write(to: URL(fileURLWithPath: toJSONFile), options: .atomic)
			} catch {
				// Handle Error
				return false
			}
		}
		
		return true
	}

	
	// Write a JSON dict to a file
	func serialize(dict: NSDictionary, toJSONFile: String) -> Bool
	{
		if JSONSerialization.isValidJSONObject(dict) {
			do {
				let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
				try jsonData.write(to: URL(fileURLWithPath: toJSONFile), options: .atomic)
			} catch {
				// Handle Error
				return false
			}
		}
		
		return true
	}
}
