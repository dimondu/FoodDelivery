//
//  MainCoordinator.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 27.10.2024.
//

import UIKit

final class MainCoordinator: BaseCoordinator {

	// MARK: - Dependencies
	private let tabBarController: UITabBarController

	// MARK: - Private properties
	private let pages: [TabbarPage]

	// MARK: - Initialization
	init(tabBarController: UITabBarController, pages: [TabbarPage]) {
		self.tabBarController = tabBarController
		self.pages = pages
	}

	// MARK: - Internal methods
	override func start() {
		tabBarController.viewControllers?.enumerated().forEach { index, item in
			guard let controller = item as? UINavigationController else {
				return
			}
			runFlowByIndex(index, on: controller)
		}
	}
}

// MARK: - run Flows -
private extension MainCoordinator {
	func runFlowByIndex(_ index: Int, on controller: UINavigationController) {
		let coordinator: ICoordinator
		switch pages[index] {
		case .profile:
			coordinator = ProfileCoordinator(navigationController: controller)
		case .home:
			coordinator = HomeCoordinator(navigationController: controller)
		case .shoppingCart:
			coordinator = ShoppingCartCoordinator(navigationController: controller)
		}
		addDependency(coordinator)
		coordinator.start()
	}
}
