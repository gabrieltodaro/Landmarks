//
//  CircleImage.swift
//  Landmarks
//
//  Created by Gabriel Patané Todaro on 05/02/24.
//

import SwiftUI

struct CircleImage: View {
	var image: Image

    var body: some View {
		image
			.clipShape(Circle())
			.overlay {
				Circle().stroke(.white, lineWidth: 4)
			}
			.shadow(radius: 7)
    }
}

#Preview {
	CircleImage(image: Image("turtlerock"))
}
