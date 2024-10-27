//
//  TabBarController.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 27.10.2024.
//

import UIKit

final class TabBarController: UITabBarController {

	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
	}
}

private extension TabBarController {
	func setup() {
		let controllers: [UINavigationController] = TabbarPage.allCases.map(getTabBarController)

		setViewControllers(controllers, animated: true)
		selectedIndex = TabbarPage.initialTabbarPage.pageOrderNumber
	}

	func getTabBarController(_ page: TabbarPage) -> UINavigationController {
		let navigationController = UINavigationController()

		navigationController.tabBarItem = UITabBarItem(
			title: nil,
			image: page.pageIconValue(),
			tag: page.pageOrderNumber
		)

		return navigationController
	}
}
