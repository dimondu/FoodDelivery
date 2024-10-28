//
//  ShoppingCartCoordinator.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 27.10.2024.
//

import UIKit

final class ShoppingCartCoordinator: ICoordinator {

	// MARK: - Dependencies
	private let navigationController: UINavigationController

	// MARK: - Initialization
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	// MARK: - Internal methods
	func start() {
		showShoppingCartScene()
	}

	// MARK: - Private methods
	private func showShoppingCartScene() {
		let viewcontroller = ShoppingCartViewController()
		navigationController.pushViewController(viewcontroller, animated: true)
	}
}
