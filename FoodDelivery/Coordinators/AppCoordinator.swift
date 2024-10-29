//
//  AppCoordinator.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 27.10.2024.
//

import UIKit

final class AppCoordinator: BaseCoordinator {

	// MARK: - Dependencies
	private let navigationController: UINavigationController
	private var window: UIWindow?

	// MARK: - Initialization
	init(window: UIWindow?, navigationController: UINavigationController) {
		self.window = window
		self.navigationController = navigationController
	}

	// MARK: - Internal methods
	override func start() {
		runMainFlow()
	}

	// MARK: - Private methods
	private func runMainFlow() {
		let tabBarController = TabBarController()
		let coordinator = MainCoordinator(
			tabBarController: tabBarController,
			pages: TabbarPage.allCases
		)
		addDependency(coordinator)
		coordinator.start()

		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()

		navigationController.isNavigationBarHidden = true
		navigationController.setViewControllers([tabBarController], animated: true)
	}
}
