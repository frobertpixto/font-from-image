//
//  ContentView.swift
//  GenerateFontImages
//
//  Created by Francois Robert on 2022-06-16.
//

import SwiftUI

struct GenerateFontImagesView: View {
    var body: some View {
		 Color(.white).overlay(
				 VStack {
					 Spacer()
					 Text("Output will be displayed in Xcode console")
					 Spacer()
					 Button(action: {
						 self.listFontsAction()
					 }, label: { Text("List fonts on Device") })
					 Spacer()
					 Button(action: {
						 self.generateImagesAction()
					 }, label: { Text("Generate Font Images") })
					 Spacer()

				 }).buttonStyle(GradientButtonStyle())
	 }
}

// MARK: - Event Handlers
extension GenerateFontImagesView {
	func listFontsAction() {
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
	
	func generateImagesAction() {
		print("generateImagesAction action")
		let fontGenerator = FontGenerator()

		fontGenerator.generateFontImages()
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GenerateFontImagesView()
			 .preferredColorScheme(.light)
			 .frame(width: 400.0, height: 400.0)
    }
}
