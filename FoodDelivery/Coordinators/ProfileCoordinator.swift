//
//  ProfileCoordinator.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 27.10.2024.
//

import UIKit

final class ProfileCoordinator: ICoordinator {

	// MARK: - Dependencies
	private let navigationController: UINavigationController

	// MARK: - Initialization
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	// MARK: - Internal methods
	func start() {
		showProfileScene()
	}

	func showProfileScene() {
		let viewcontroller = ProfileViewController()
		navigationController.pushViewController(viewcontroller, animated: true)
	}
}
