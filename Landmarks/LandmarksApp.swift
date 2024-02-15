//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by Gabriel Patané Todaro on 05/02/24.
//

import SwiftUI

/*
 An app that uses the SwiftUI app life cycle has a structure that conforms to the App protocol. The structure’s body property returns one or more scenes, which in turn provide content for display. The @main attribute identifies the app’s entry point.
 */
@main
struct LandmarksApp: App {
	/*
	 Use the @State attribute to initialize a model object the same way you use it to initialize properties inside a view.
	 Just like SwiftUI initializes state in a view only once during the lifetime of the view, it initializes state in an app only once during the lifetime of the app.
	 */
	@State private var modelData = ModelData()

	var body: some Scene {
		WindowGroup {
			ContentView()
				.environment(modelData)
		}
		/*
		 Scene modifiers work like view modifiers, except that you apply them to scenes instead of views.
		 */
#if !os(watchOS)
		.commands {
			LandmarkCommands()
		}
#endif


#if os(watchOS)
		WKNotificationScene(controller: NotificationController.self, category: "LandmarkNear")
#endif



#if os(macOS)
		Settings {
			LandmarkSettings()
		}
#endif
	}
}
