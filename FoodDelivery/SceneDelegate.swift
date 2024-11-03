//
//  SceneDelegate.swift
//  FoodDelivery
//
//  Created by Дмитрий Дуров on 21.10.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
	private var appCoordinator: ICoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)

        RootContainer.shared.registerDependencies()
		appCoordinator = AppCoordinator(
			window: window,
			navigationController: UINavigationController()
		)
		appCoordinator?.start()

        self.window = window
    }
}
