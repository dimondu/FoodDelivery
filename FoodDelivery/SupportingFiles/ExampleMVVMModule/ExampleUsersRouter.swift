//
//  ExampleUsersRouter.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 06.11.2024.
//

import UIKit

struct ExampleUsersRouter: IRouterType {

    let viewController: UIViewController

    init(transitionHandler: UIViewController) {
        viewController = transitionHandler
    }

    func showAlert(title: String) {

        let alertController = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .alert
        )

        alertController.addAction(.init(title: "OK", style: .default))

        viewController.present(alertController, animated: true)
    }
}
