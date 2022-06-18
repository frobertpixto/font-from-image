//
//  GenerateFontImagesApp.swift
//  GenerateFontImages
//
//  Created by Francois Robert on 2022-06-16.
//

import SwiftUI

@main
struct GenerateFontImagesApp: App {
    var body: some Scene {
        WindowGroup {
            GenerateFontImagesView()
				  .preferredColorScheme(.light)
				  .frame(minWidth: 400, minHeight: 400.0)
				  .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
