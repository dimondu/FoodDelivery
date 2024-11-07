//
//  ScreenBuilder.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 06.11.2024.
//

import UIKit

/// Технический протокол для обслуживания, напрямую его использовать не нужно,
/// он не понадобится.
protocol IHasEmptyInitialization {
    init()
}

/// Конструктор всех частей архитектуры в единую сущность.
protocol IScreenBuilder: IHasEmptyInitialization {

    associatedtype ViewController: UIViewController & IViewType

    /// Здесь передаем все зависимости экрана.
    var dependencies: ViewController.ViewModel.Dependencies { get }
}

extension IScreenBuilder {

    /// Здесь создается контроллер, модель и роутер, и связываются друг с
    /// другом.
    func build(
        _ inputs: ViewController.ViewModel.Inputs
    ) -> ViewController
        where ViewController.ViewModel.Routes
        .TransitionHandler == UIViewController {

        let viewController = ViewController.make()
        viewController.loadViewIfNeeded()

        let viewModel = ViewController.ViewModel.configure(
            input: inputs,
            binding: viewController.bindings,
            dependency: dependencies,
            router: ViewController.ViewModel
                .Routes(transitionHandler: viewController)
        )

        viewController.bind(to: viewModel)

        return viewController
    }
}
