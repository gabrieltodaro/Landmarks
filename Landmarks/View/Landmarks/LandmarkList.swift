//
//  LandmarkList.swift
//  Landmarks
//
//  Created by Gabriel Patané Todaro on 05/02/24.
//

import SwiftUI

struct LandmarkList: View {
	@Environment(ModelData.self) var modelData
	@State private var showFavoritesOnly = false
	@State private var filter = FilterCategory.all
	@State private var selectedLandmark: Landmark?

	enum FilterCategory: String, CaseIterable, Identifiable {
		case all = "All"
		case lakes = "Lakes"
		case rivers = "Rivers"
		case mountains = "Mountains"

		var id: FilterCategory { self }
	}

	var index: Int? {
		modelData.landmarks.firstIndex(where: { $0.id == selectedLandmark?.id })
	}

	var filteredLandmarks: [Landmark] {
		modelData.landmarks.filter { landmark in
			(!showFavoritesOnly || landmark.isFavorite)
			&& (filter == .all || filter.rawValue == landmark.category.rawValue)
		}
	}

	var title: String {
		let title = filter == .all ? "Landmarks" : filter.rawValue
		return showFavoritesOnly ? "Favorite \(title)" : title
	}

	var body: some View {
		@Bindable var modelData = modelData

		NavigationSplitView {
			List(selection: $selectedLandmark) {
				ForEach(filteredLandmarks) { landmark in
					NavigationLink {
						LandmarkDetail(landmark: landmark)
					} label: {
						LandmarkRow(landmark: landmark)
					}
					/*
					 The tag associates a particular landmark with the given item in the ForEach, which then drives the selection.
					 */
					.tag(landmark)
				}
			}
			.animation(.default, value: filteredLandmarks)
			.navigationTitle(title)
			.frame(minWidth: 300)
			.toolbar {
				ToolbarItem {
					Menu {
						Picker("Category", selection: $filter) {
							ForEach(FilterCategory.allCases) { category in
								Text(category.rawValue).tag(category)
							}
						}
						.pickerStyle(.inline)

						Toggle(isOn: $showFavoritesOnly) {
							Text("Favorites only")
						}
					} label: {
						Label("Filter", systemImage: "slider.horizontal.3")
					}
				}
			}
		} detail: {
			Text("Select a Landmark")
		}
		/*
		 You perform a look-up here to ensure that you are modifying the landmark stored in the model, and not a copy.
		 */
		.focusedValue(\.selectedLandmark, $modelData.landmarks[index ?? 0])
	}
}


#Preview {
	LandmarkList()
		.environment(ModelData())
}
