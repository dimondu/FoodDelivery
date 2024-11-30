//
//  ExampleUsersRouter.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 06.11.2024.
//

import UIKit

struct ExampleUsersRouter: IRouterType {

    private let router: Router

    init(transitionHandler: UIViewController) {
        router = Router(transitionHandler: transitionHandler)
    }

    func showAlert(title: String) {

        let alertController = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .alert
        )

        alertController.addAction(.init(title: "OK", style: .default))

        router.present(alertController, animated: true)
    }
}
