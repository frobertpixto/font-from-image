//
//  ViewController.swift
//  GenerateFontImages
//
//  Created by Francois Robert on 2018-10-28.
//

import Cocoa

class ViewController: NSViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.
	}

	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}

	// List all Font families name and their fonts name
	@IBAction func listFontsAction(_ sender: Any) {
		let fontFamilyNames = NSFontManager.shared.availableFontFamilies
		
		var familyCount = 0
		var fontCount   = 0
		
		print("avaialble fonts.")
		
		for fontFamilyName in fontFamilyNames {
			print("Font family: \(fontFamilyName)")
			familyCount += 1
			let fontInfo = NSFontManager.shared.availableMembers(ofFontFamily: fontFamilyName)
			
			if fontInfo != nil {
				let fontInfoData = fontInfo!
				for fontInfoData1 in fontInfoData {
					if fontInfoData1.count > 0 {
						fontCount += 1
						let fontNameInfo = fontInfoData1[0] as! String
						print("   \"\(fontNameInfo)\",")
					}
				}
			}
		}
		
		print("Font families: \(familyCount). Total font: \(fontCount)")
	}

	//
	@IBAction func generateImageAction(_ sender: Any) {
		print("generateImageAction action")
		let fontGenerator = FontGenerator()

		fontGenerator.generateFontImages()
	}

}

