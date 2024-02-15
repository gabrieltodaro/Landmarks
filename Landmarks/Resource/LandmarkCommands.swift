//
//  LandmarkCommands.swift
//  Landmarks
//
//  Created by Gabriel Patané Todaro on 15/02/24.
//

import SwiftUI

struct LandmarkCommands: Commands {
	@FocusedBinding(\.selectedLandmark) var selectedLandmark

	var body: some Commands {
		SidebarCommands()

		CommandMenu("Landmark") {
			Button("\(selectedLandmark?.isFavorite == true ? "Remove" : "Mark") as Favorite") {
				selectedLandmark?.isFavorite.toggle()
			}
			.keyboardShortcut("f", modifiers: [.shift, .option])
			.disabled(selectedLandmark == nil)
		}
	}
}

/*
 The pattern for defining focused values resembles the pattern for defining new Environment values: Use a private key to read and write a custom property on the system-defined FocusedValues structure.
 */
private struct SelectedLandmarkKey: FocusedValueKey {
	typealias Value = Binding<Landmark>
}

extension FocusedValues {
	var selectedLandmark: Binding<Landmark>? {
		get { self[SelectedLandmarkKey.self] }
		set { self[SelectedLandmarkKey.self] = newValue }
	}
}
