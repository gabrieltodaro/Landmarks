//
//  FavoriteButton.swift
//  Landmarks
//
//  Created by Gabriel Patané Todaro on 05/02/24.
//

import SwiftUI

struct FavoriteButton: View {
	/*
	 The binding property wrapper enables you to read and write between a property that stores data and a view that displays and changes the data.
	 Because you use a binding, changes made inside this view propagate back to the data source.
	 */
	@Binding var isSet: Bool

	var body: some View {
		Button {
			isSet.toggle()
		} label: {
			/*
			 The title string that you provide for the button’s label doesn’t appear in the UI when you use the iconOnly label style, but VoiceOver uses it to improve accessibility.
			 */
			Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
				.labelStyle(.iconOnly)
				.foregroundStyle(isSet ? .yellow : .gray)
		}
	}
}


#Preview {
	FavoriteButton(isSet: .constant(true))
}
