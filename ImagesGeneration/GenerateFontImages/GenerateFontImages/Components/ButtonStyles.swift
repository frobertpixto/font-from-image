//
//  ButtonStyles.swift
//  MegaCalc1
//
//  Created by Francois Robert on 2022-01-01.
//

import SwiftUI

struct GradientButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
	 configuration.label
		.frame(width: 200, height: 40)
		.opacity(configuration.isPressed ? 0.2 : 1)
		.background(
		  RadialGradient(
			 gradient: Gradient(
				colors: [Color.white, Color.gray]
			 ),
			 center: .center,
			 startRadius: 0,
			 endRadius: 90
		  )
		)
  }
}

