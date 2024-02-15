//
//  PageControl.swift
//  Landmarks
//
//  Created by Gabriel Patané Todaro on 08/02/24.
//

import SwiftUI
import UIKit

/*
 UIViewRepresentable and UIViewControllerRepresentable types have the same life cycle, with methods that correspond to their underlying UIKit types.
 */
struct PageControl: UIViewRepresentable {
	var numberOfPages: Int
	@Binding var currentPage: Int

	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}

	class Coordinator: NSObject {
		var control: PageControl

		init(_ control: PageControl) {
			self.control = control
		}

		@objc
		func updateCurrentPage(sender: UIPageControl) {
			control.currentPage = sender.currentPage
		}
	}

	func makeUIView(context: Context) -> UIPageControl {
		let control = UIPageControl()
		control.numberOfPages = numberOfPages
		control.addTarget(
			context.coordinator,
			action: #selector(Coordinator.updateCurrentPage(sender:)),
			for: .valueChanged)

		return control
	}

	func updateUIView(_ uiView: UIPageControl, context: Context) {
		uiView.currentPage = currentPage
	}
}
