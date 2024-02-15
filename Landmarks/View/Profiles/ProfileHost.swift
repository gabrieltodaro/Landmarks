//
//  ProfileHost.swift
//  Landmarks
//
//  Created by Gabriel Patané Todaro on 07/02/24.
//

import SwiftUI

/*
 SwiftUI provides storage in the environment for values you can access using the @Environment property wrapper. Earlier you used @Environment to retrieve a class that you stored in the environment. Here, you use it to access the editMode value that’s built into the environment to read or write the edit scope.
 */
struct ProfileHost: View {
	@Environment(\.editMode) var editMode
	@Environment(ModelData.self) var modelData
	@State private var draftProfile = Profile.default

	var body: some View {
		VStack(alignment: .leading, spacing: 20) {
			HStack {
				/*
				 Unlike the Done button that EditButton provides, the Cancel button doesn’t apply the edits to the real profile data in its closure.
				 */
				if editMode?.wrappedValue == .active {
					Button("Cancel", role: .cancel) {
						draftProfile = modelData.profile
						editMode?.animation().wrappedValue = .inactive
					}
				}
				Spacer()
				EditButton()
			}
			
			if editMode?.wrappedValue == .inactive {
				ProfileSummary(profile: modelData.profile)
			} else {
				ProfileEditor(profile: $draftProfile)
					.onAppear {
						draftProfile = modelData.profile
					}
					.onDisappear {
						modelData.profile = draftProfile
					}
			}
		}
		.padding()
	}
}

#Preview {
	ProfileHost()
		.environment(ModelData())
}
