//
//  ContentView.swift
//  Landmarks
//
//  Created by Gabriel Patané Todaro on 05/02/24.
//

import SwiftUI

struct ContentView: View {
	@State private var selection: Tab = .featured

	enum Tab {
		case featured
		case list
	}

    var body: some View {
		/*
		 TabView doesn't have a tabItem by default. You need to create one for each tab.
		 */
		TabView(selection: $selection) {
			CategoryHome()
				.tabItem {
					Label("Featured", systemImage: "star")
				}
				.tag(Tab.featured)

			LandmarkList()
				.tabItem {
					Label("List", systemImage: "list.bullet")
				}
				.tag(Tab.list)
		}
    }
}

#Preview {
    ContentView()
		.environment(ModelData())
}
