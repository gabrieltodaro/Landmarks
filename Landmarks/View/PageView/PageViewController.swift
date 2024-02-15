//
//  PageViewController.swift
//  Landmarks
//
//  Created by Gabriel Patané Todaro on 08/02/24.
//

import SwiftUI
import UIKit

struct PageViewController<Page: View>: UIViewControllerRepresentable {
	typealias UIViewControllerType = UIPageViewController

	@Binding var currentPage: Int

	var pages: [Page]

	/*
	 A SwiftUI view that represents a UIKit view controller can define a Coordinator type that SwiftUI manages and provides as part of the representable view’s context.
	 */
	class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
		var parent: PageViewController
		var controllers = [UIViewController]()

		init(_ pageViewController: PageViewController) {
			parent = pageViewController
			controllers = parent.pages.map { UIHostingController(rootView: $0) }
		}

		/*
		 These two methods establish the relationships between view controllers, so that you can swipe back and forth between them.
		 */
		func pageViewController(_ pageViewController: UIPageViewController,
								viewControllerBefore viewController: UIViewController) -> UIViewController? {
			guard let index = controllers.firstIndex(of: viewController) else {
				return nil
			}
			if index == 0 {
				return controllers.last
			}
			return controllers[index - 1]
		}

		func pageViewController(_ pageViewController: UIPageViewController,
								viewControllerAfter viewController: UIViewController) -> UIViewController? {
			guard let index = controllers.firstIndex(of: viewController) else {
				return nil
			}
			if index + 1 == controllers.count {
				return controllers.first
			}
			return controllers[index + 1]
		}

		func pageViewController(_ pageViewController: UIPageViewController,
								didFinishAnimating finished: Bool,
								previousViewControllers: [UIViewController],
								transitionCompleted completed: Bool) {
			if completed,
			   let visibleViewController = pageViewController.viewControllers?.first,
			   let index = controllers.firstIndex(of: visibleViewController) {
				parent.currentPage = index
			}
		}
	}

	/*
	 SwiftUI calls this makeCoordinator() method before makeUIViewController(context:), so that you have access to the coordinator object when configuring your view controller.
	 You can use this coordinator to implement common Cocoa patterns, such as delegates, data sources, and responding to user events via target-action.
	 */
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}

	/*
	 SwiftUI calls this method a single time when it’s ready to display the view, and then manages the view controller’s life cycle.
	 */
	func makeUIViewController(context: Context) -> UIPageViewController {
		let pageViewController = UIPageViewController(
			transitionStyle: .scroll,
			navigationOrientation: .horizontal)
		pageViewController.dataSource = context.coordinator
		pageViewController.delegate = context.coordinator

		return pageViewController
	}

	/*
	 For now, you create the UIHostingController that hosts the page SwiftUI view on every update. Later, you’ll make this more efficient by initializing the controller only once for the life of the page view controller.
	 */
	func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) {
		uiViewController.setViewControllers(
			[context.coordinator.controllers[currentPage]],
			direction: .forward,
			animated: true
		)
	}
}
