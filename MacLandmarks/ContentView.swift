//
//  ContentView.swift
//  MacLandmarks
//
//  Created by Gabriel Patané Todaro on 08/02/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
			LandmarkList()
				.frame(minWidth: 700, minHeight: 300)
        }
        .padding()
    }
}

#Preview {
    ContentView()
		.environment(ModelData())
}
