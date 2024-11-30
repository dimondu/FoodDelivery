//
//  Router.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 20.11.2024.
//

import UIKit

class Router {
    weak var viewController: UIViewController?

    required init(transitionHandler: UIViewController) {
        self.viewController = transitionHandler
    }

    func show<Builder: IScreenBuilder>(
        _ type: Builder.Type,
        inputs: Builder.ViewController.ViewModel.Inputs,
        animated: Bool = true
    )
        where Builder.ViewController.ViewModel.Routes
        .TransitionHandler == UIViewController {
        let builder = Builder()
        let vc = builder.build(inputs)
        push(vc, animated: animated)
    }

    func pop(animated: Bool = true) {
        viewController?.navigationController?
            .popViewController(animated: animated)
    }

    func present(_ vc: UIViewController, animated: Bool = true) {
        viewController?.present(vc, animated: animated)
    }

    private func push(_ vc: UIViewController, animated: Bool = true) {
        viewController?.navigationController?.pushViewController(
            vc,
            animated: animated
        )
    }
}
