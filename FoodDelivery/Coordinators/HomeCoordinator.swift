//
//  HomeCoordinator.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 27.10.2024.
//

import UIKit

final class HomeCoordinator: ICoordinator {

	// MARK: - Dependencies
	private let navigationController: UINavigationController

	// MARK: - Initialization
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	// MARK: - Internal methods
	func start() {
		showHomeScene()
	}

	// MARK: - Private methods
	private func showHomeScene() {
		let viewcontroller = HomeViewController()
		navigationController.pushViewController(viewcontroller, animated: true)
	}
}
